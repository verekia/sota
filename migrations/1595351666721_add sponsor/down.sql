
ALTER TABLE "public"."user" ALTER COLUMN "name" DROP NOT NULL;

ALTER TABLE "public"."user" DROP COLUMN "name";

DROP TABLE "public"."sponsor";

ALTER TABLE "public"."post" ALTER COLUMN "title" DROP NOT NULL;
