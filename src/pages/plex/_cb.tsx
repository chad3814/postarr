import { MyPlexAccount } from "@ctrl/plex";
import type { GetServerSidePropsContext, GetServerSidePropsResult } from "next";
import db from "../../lib/db";
import { WebLogin } from "@ctrl/plex/dist/src/myplex.types";

export async function getServerSideProps(context: GetServerSidePropsContext): Promise<GetServerSidePropsResult<void>> {
    const id = Number(context.query.id);

    if (isNaN(id)) {
        console.log('nan', context.query);
        return {
            notFound: true
        }
    }

    const token = await db.plexToken.findFirst({
        where: {
            id
        }
    });

    if (!token) {
        console.log('no token', id);
        return {
            notFound: true
        }
    }

    const webLogin: WebLogin = {
        id: token.plexId,
        code: token.plexCode,
        uri: '',
    };

    try {
        const plexAccount = await MyPlexAccount.webLoginCheck(webLogin, 60);
        const resources = await plexAccount.resources();
        await db.plex.createMany({
            data: resources.map(
                server => ({
                    name: server.name,
                    tokenId: token.id,
                })
            )
        });
        for (const resource of resources) {
            const plex = await db.plex.findFirst({
                where: {
                    name: resource.name,
                    tokenId: token.id,
                }
            });
            if (!plex) {
                console.error('missing plex:', resource.name, token);
                continue;
            }
            const server = await resource.connect();
            const library = await server.library();
            const sections = await library.sections();
            await db.plexLibrary.createMany({
                data: sections.map(
                    section => ({
                        plexId: plex.id,
                        isShows: section.type === 'show',
                        title: section.title,
                    })
                )
            });
        }
    } catch(err) {
        console.log('error', err);
        return {
            notFound: true
        }
    }

    return {
        redirect: {
            statusCode: 302,
            destination: '/',
        },
    };
}


export default function PlexCb() {
    return null;
}