-- Table: public.Bakici

-- DROP TABLE IF EXISTS public."Bakici";

CREATE TABLE IF NOT EXISTS public."Bakici"
(
    -- Inherited from table public."İnsan": "ID" integer NOT NULL DEFAULT nextval('"İnsan_ID_seq"'::regclass),
    -- Inherited from table public."İnsan": "Ad-Soyad" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    -- Inherited from table public."İnsan": "TelefonNo" character varying(10) COLLATE pg_catalog."default",
    -- Inherited from table public."İnsan": "E-posta" character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT "BakıcıID" PRIMARY KEY ("ID"),
    CONSTRAINT "BakiciTelefonNoUnique" UNIQUE ("TelefonNo")
)
    INHERITS (public."İnsan")

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Bakici"
    OWNER to postgres;