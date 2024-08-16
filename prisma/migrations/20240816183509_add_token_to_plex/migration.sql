/*
  Warnings:

  - Added the required column `tokenId` to the `Plex` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Plex" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "tokenId" INTEGER NOT NULL,
    CONSTRAINT "Plex_tokenId_fkey" FOREIGN KEY ("tokenId") REFERENCES "PlexToken" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Plex" ("id", "name") SELECT "id", "name" FROM "Plex";
DROP TABLE "Plex";
ALTER TABLE "new_Plex" RENAME TO "Plex";
CREATE UNIQUE INDEX "Plex_name_tokenId_key" ON "Plex"("name", "tokenId");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
