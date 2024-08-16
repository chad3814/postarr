import Head from "next/head";
import { Inter } from "next/font/google";
import styles from "@/styles/Home.module.css";
import { gql, useQuery } from '@apollo/client'
import { Plex } from "@prisma/client";
import Link from "next/link";

const inter = Inter({ subsets: ["latin"] });

const PlexServers = gql`
  query {
    plexes {
      id
      name
    }
  }
`;

export default function Home() {
  const { data, loading, error } = useQuery<{plexes: Plex[]}>(PlexServers);

  if (loading) return <p>Loading...</p>
  if (error) return <p>Oh no... {error.message}</p>

  const plexes = data?.plexes.map(plex => <Link key={plex.id} href={`/plex/${plex.id}`}>{plex.name}</Link>)

  return (
    <>
      <Head>
        <title>Postarr</title>
        <meta name="description" content="Add posters and title cards to Plex" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className={`${styles.main} ${inter.className}`}>
        <h2>Plex Servers:</h2>
        {plexes}
        <Link href="/plex/add">Add</Link>
      </main>
    </>
  );
}
