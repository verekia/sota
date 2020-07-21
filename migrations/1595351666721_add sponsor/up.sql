
ALTER TABLE "public"."post" ALTER COLUMN "title" SET NOT NULL;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE TABLE "public"."sponsor"("id" uuid NOT NULL DEFAULT gen_random_uuid(), "createdAt" timestamptz NOT NULL DEFAULT now(), "updatedAt" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, PRIMARY KEY ("id") );
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updatedAt"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updatedAt" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_sponsor_updatedAt"
BEFORE UPDATE ON "public"."sponsor"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_sponsor_updatedAt" ON "public"."sponsor" 
IS 'trigger to set value of column "updatedAt" to current timestamp on row update';

ALTER TABLE "public"."user" ADD COLUMN "name" text NULL;

ALTER TABLE "public"."user" ALTER COLUMN "name" SET NOT NULL;
