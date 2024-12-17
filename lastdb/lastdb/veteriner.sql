-- Table: public.Veteriner

-- DROP TABLE IF EXISTS public."Veteriner";

CREATE TABLE IF NOT EXISTS public."Veteriner"
(
    -- Inherited from table public."İnsan": "ID" integer NOT NULL DEFAULT nextval('"İnsan_ID_seq"'::regclass),
    -- Inherited from table public."İnsan": "Ad-Soyad" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    -- Inherited from table public."İnsan": "TelefonNo" character varying(10) COLLATE pg_catalog."default",
    -- Inherited from table public."İnsan": "E-posta" character varying(100) COLLATE pg_catalog."default",
    "ZiyaretTarihi" date NOT NULL,
    CONSTRAINT "VeterinerID" PRIMARY KEY ("ID"),
    CONSTRAINT "VeterinerTelefonNoUnique" UNIQUE ("TelefonNo")
)
    INHERITS (public."İnsan")

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Veteriner"
    OWNER to postgres;