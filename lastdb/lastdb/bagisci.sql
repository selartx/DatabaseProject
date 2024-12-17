-- Table: public.Bagisci

-- DROP TABLE IF EXISTS public."Bagisci";

CREATE TABLE IF NOT EXISTS public."Bagisci"
(
    -- Inherited from table public."İnsan": "ID" integer NOT NULL DEFAULT nextval('"İnsan_ID_seq"'::regclass),
    -- Inherited from table public."İnsan": "Ad-Soyad" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    -- Inherited from table public."İnsan": "TelefonNo" character varying(10) COLLATE pg_catalog."default",
    -- Inherited from table public."İnsan": "E-posta" character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT "Bağışçı_pkey" PRIMARY KEY ("ID"),
    CONSTRAINT "TelefonNo" UNIQUE ("TelefonNo")
)
    INHERITS (public."İnsan")

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Bagisci"
    OWNER to postgres;