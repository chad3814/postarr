import { gql, useQuery } from "@apollo/client";
import { Plex, PlexLibrary } from "@prisma/client";
import React from "react";
import type { GetServerSidePropsContext, GetServerSidePropsResult } from "next";

const GetPlex = gql`
    query GetPlex($id: Int!) {
        plex(where:{id: $id}) {
            id
            name
            libraries {
                id
                title
                isShows
            }
        }
    }
`

export async function getServerSideProps(context: GetServerSidePropsContext): Promise<GetServerSidePropsResult<Props>> {
    const id = Number(context.query.id);
    if(isNaN(id)) {
        return {
            notFound: true,
        };
    }

    return {
        props: {
            id,
        },
    };
}


type Props = {
    id: number;
};

export default function PlexServer({ id }: Props) {
    const { data, loading, error } = useQuery<{plex: Plex & { libraries: PlexLibrary[]}}>(GetPlex, { variables: { id }});

    if (loading) return "Loading...";
    if (error) return `Error: ${error}`;

    const libraries = data?.plex.libraries.map(
        library => <li key={library.id}>{library.title}</li>
    );
    return <fieldset>
        <legend>{data?.plex.name}</legend>
        <div>libraries:</div>
        <ul>{libraries}</ul>
    </fieldset>
}