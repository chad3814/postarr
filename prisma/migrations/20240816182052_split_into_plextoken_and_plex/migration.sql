/*
  Warnings:

  - You are about to drop the column `plexCode` on the `Plex` table. All the data in the column will be lost.
  - You are about to drop the column `plexId` on the `Plex` table. All the data in the column will be lost.
  - You are about to drop the column `token` on the `Plex` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "PlexToken" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "plexId" INTEGER NOT NULL,
    "plexCode" TEXT NOT NULL,
    "token" TEXT
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Plex" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT
);
INSERT INTO "new_Plex" ("id", "name") SELECT "id", "name" FROM "Plex";
DROP TABLE "Plex";
ALTER TABLE "new_Plex" RENAME TO "Plex";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "PlexToken_plexId_key" ON "PlexToken"("plexId");
