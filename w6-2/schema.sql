-- In class assignment: Create a ERD using Spotify as the inspo, now make the schema 

CREATE TABLE users {
    "id" INTEGER, 
    "name" TEXT, 
    "email" TEXT UNIQUE, 
    "status" TEXT NOT NULL CHECK IN ('Inactive','Free','Premium'),
    PRIMARY KEY ("id")
}

CREATE TABLE song {
    "id" INTEGER,
    "title" TEXT NOT NULL,
    PRIMARY KEY ("id"),
}

CREATE TABLE playlists {
    "playlist_name" TEXT,
    "playlist_id" INTEGER,
    "owner" TEXT, 
    PRIMARY KEY ("playlist_id"),
    FOREIGN KEY ("owner") REFERENCES "users"("id")
}

CREATE TABLE artists {
    "artist" TEXT,
    PRIMARY ("artist")
}

CREATE TABLE song_playlist {
    "song_id" INTEGER,
    "play_id" INTEGER,
    FOREIGN KEY ("song_id") REFERENCES "song"("id"),
    FOREIGN KEY ("play_id") REFERENCES "playlists"("playlist_id")
}

CREATE TABLE song_artist {
    "artist_id" INTEGER,
    "song_id" INTEGER, 
    FOREIGN KEY ("song_id") REFERENCES "song"("id"),
    FOREIGN KEY ("artist_id") REFERENCES "artist"("id")
}

