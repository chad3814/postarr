import { MyPlexAccount } from "@ctrl/plex";
import type { GetServerSidePropsContext, GetServerSidePropsResult } from "next";
import db from "../../lib/db";

export async function getServerSideProps(context: GetServerSidePropsContext): Promise<GetServerSidePropsResult<void>> {
    console.log('url', context.req.headers.host);
    const followUrl = new URL('/plex/_cb', `http://${context.req.headers.host}`);
    const webLogin = await MyPlexAccount.getWebLogin(followUrl.toString());
    const { id } = await db.plexToken.create({
        data: {
            plexId: webLogin.id,
            plexCode: webLogin.code,
        }
    });

    return {
        redirect: {
            statusCode: 302,
            destination: webLogin.uri + encodeURIComponent(`?id=${id}`),
        },
    };
}


export default function AddPlexServer() {
    return null;
}