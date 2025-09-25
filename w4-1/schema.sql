CREATE TABLE members (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "membership_type" TEXT NOT NULL CHECK("membership_type" IN ('Standard','Premium', 'VIP')),
    "join_date" TEXT NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP)),
    PRIMARY KEY ("id")
);


CREATE TABLE classes(
    "class_id" INTEGER,
    "class_name" TEXT NOT NULL,
    "class_type" TEXT,
    "teacher" TEXT NOT NULL,
    "schedule" TEXT NOT NULL CHECK ("schedule" IN ('morning','afternoon','evening')),
    PRIMARY KEY ("class_id")
);

CREATE TABLE "attendence"(
    "attendence_id" INTEGER,
    "member_id" INTEGER, 
    "class_id" INTEGER,
    FOREIGN KEY ("member_id") REFERENCES "members"("id"),
    FOREIGN KEY ("class_id") REFERENCES "classes"("class_id")
);