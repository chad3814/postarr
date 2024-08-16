-- CreateTable
CREATE TABLE "Plex" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "plexId" INTEGER NOT NULL,
    "plexCode" TEXT NOT NULL,
    "token" TEXT
);

-- CreateTable
CREATE TABLE "Sonarr" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "url" TEXT NOT NULL,
    "token" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Radarr" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "url" TEXT NOT NULL,
    "token" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Reddit" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "token" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "PlexLibrary" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "plexId" INTEGER NOT NULL,
    "isShows" BOOLEAN NOT NULL,
    "title" TEXT NOT NULL,
    CONSTRAINT "PlexLibrary_plexId_fkey" FOREIGN KEY ("plexId") REFERENCES "Plex" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Movie" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "radarrId" INTEGER NOT NULL,
    "plexLibraryId" INTEGER NOT NULL,
    CONSTRAINT "Movie_radarrId_fkey" FOREIGN KEY ("radarrId") REFERENCES "Radarr" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Movie_plexLibraryId_fkey" FOREIGN KEY ("plexLibraryId") REFERENCES "PlexLibrary" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Show" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "sonarrId" INTEGER NOT NULL,
    "plexLibraryId" INTEGER NOT NULL,
    CONSTRAINT "Show_sonarrId_fkey" FOREIGN KEY ("sonarrId") REFERENCES "Sonarr" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Show_plexLibraryId_fkey" FOREIGN KEY ("plexLibraryId") REFERENCES "PlexLibrary" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Season" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT,
    "number" INTEGER NOT NULL,
    "isSpecials" BOOLEAN NOT NULL,
    "showId" INTEGER NOT NULL,
    CONSTRAINT "Season_showId_fkey" FOREIGN KEY ("showId") REFERENCES "Show" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Episode" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT,
    "number" INTEGER NOT NULL,
    "seasonId" INTEGER NOT NULL,
    CONSTRAINT "Episode_seasonId_fkey" FOREIGN KEY ("seasonId") REFERENCES "Season" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Plex_plexId_key" ON "Plex"("plexId");

-- CreateIndex
CREATE UNIQUE INDEX "Sonarr_url_key" ON "Sonarr"("url");

-- CreateIndex
CREATE UNIQUE INDEX "Radarr_url_key" ON "Radarr"("url");
