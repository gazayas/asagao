CREATE TABLE "articles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar NOT NULL, "body" text NOT NULL, "released_at" datetime NOT NULL, "expired_at" datetime, "member_only" boolean DEFAULT 'f' NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "entries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "member_id" integer NOT NULL, "title" varchar NOT NULL, "body" text, "posted_at" datetime NOT NULL, "status" varchar DEFAULT 'draft' NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "member_images" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "member_id" integer NOT NULL, "data" blob, "content_type" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "members" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "number" integer NOT NULL, "name" varchar NOT NULL, "full_name" varchar, "email" varchar, "birthday" date, "gender" integer DEFAULT 0 NOT NULL, "administrator" boolean DEFAULT 'f' NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "hashed_password" varchar);
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE TABLE "votes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "entry_id" integer NOT NULL, "member_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_entries_on_member_id" ON "entries" ("member_id");
CREATE INDEX "index_member_images_on_member_id" ON "member_images" ("member_id");
CREATE INDEX "index_votes_on_entry_id" ON "votes" ("entry_id");
CREATE INDEX "index_votes_on_member_id" ON "votes" ("member_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20151204032740');

INSERT INTO schema_migrations (version) VALUES ('20151204052300');

INSERT INTO schema_migrations (version) VALUES ('20160130222400');

INSERT INTO schema_migrations (version) VALUES ('20160428110807');

INSERT INTO schema_migrations (version) VALUES ('20160507003530');

INSERT INTO schema_migrations (version) VALUES ('20160509015917');

INSERT INTO schema_migrations (version) VALUES ('20160510101305');

