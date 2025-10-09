-- In class assignment: Create a ERD using Spotify as the inspo, now make the schema 

CREATE TABLE users {
    "id" INTEGER, 
    "email" TEXT UNIQUE, 
    "status" TEXT NOT NULL CHECK IN ('Inactive','Free','Premium'),
    PRIMARY KEY ("id")
}

CREATE TABLE songs {
    "id" INTEGER,
    "title" TEXT NOT NULL,
    "artist_name" TEXT,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("artist_name") REFERENCES "artists"("name"),
}

CREATE TABLE artists {
    "id" INTEGER,
    "name" TEXT, 
    "artist_songs" INTEGER,
    PRIMARY KEY ("name"),
    FOREIGN KEY ("artist_songs") REFERENCES "songs"("id")
}

CREATE TABLE playlists {
    "playlist_name" TEXT,
    "users_id" INTEGER,
    "song_id" INTEGER,
    FOREIGN KEY ("song_id") REFERENCES "songs"("id"),
    FOREIGN KEY ("users_id") REFERENCES "users"("id")
}