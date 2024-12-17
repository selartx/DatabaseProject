-- Table: public.Türler

-- DROP TABLE IF EXISTS public."Türler";

CREATE TABLE IF NOT EXISTS public."Türler"
(
    "TürAdı" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Türler_pkey" PRIMARY KEY ("TürAdı")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Türler"
    OWNER to postgres;