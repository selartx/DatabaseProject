-- Table: public.Barinaklar

-- DROP TABLE IF EXISTS public."Barinaklar";

CREATE TABLE IF NOT EXISTS public."Barinaklar"
(
    "BarinakID" integer NOT NULL,
    "BarinakAdi" character varying COLLATE pg_catalog."default" NOT NULL,
    "Konum" character varying(100) COLLATE pg_catalog."default",
    "Kapasite" integer,
    "Kasa" integer,
    "İletişim" character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT "Barınaklar_pkey" PRIMARY KEY ("BarinakID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Barinaklar"
    OWNER to postgres;