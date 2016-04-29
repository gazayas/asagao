CREATE TABLE "articles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar NOT NULL, "body" text NOT NULL, "released_at" datetime NOT NULL, "expired_at" datetime, "member_only" boolean DEFAULT 'f' NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "members" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "number" integer NOT NULL, "name" varchar NOT NULL, "full_name" varchar, "email" varchar, "birthday" date, "gender" integer DEFAULT 0 NOT NULL, "administrator" boolean DEFAULT 'f' NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "hashed_password" varchar);
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20151204032740');

INSERT INTO schema_migrations (version) VALUES ('20151204052300');

INSERT INTO schema_migrations (version) VALUES ('20160130222400');

INSERT INTO schema_migrations (version) VALUES ('20160428110807');

