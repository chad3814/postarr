import Head from "next/head";
import { Inter } from "next/font/google";
import styles from "@/styles/Home.module.css";

const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  const plexes = null;
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
      </main>
    </>
  );
}
