CREATE FUNCTION public."set_current_timestamp_updatedAt"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updatedAt" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.post (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    slug text,
    title text,
    content text,
    "userId" uuid NOT NULL
);
CREATE TABLE public."user" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    username text NOT NULL,
    bio text
);
ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);
CREATE TRIGGER "set_public_post_updatedAt" BEFORE UPDATE ON public.post FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_post_updatedAt" ON public.post IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_user_updatedAt" BEFORE UPDATE ON public."user" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_user_updatedAt" ON public."user" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
ALTER TABLE ONLY public.post
    ADD CONSTRAINT "post_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
