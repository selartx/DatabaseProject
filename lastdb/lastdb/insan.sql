-- Table: public.İnsan

-- DROP TABLE IF EXISTS public."İnsan";

CREATE TABLE IF NOT EXISTS public."İnsan"
(
    "ID" integer NOT NULL DEFAULT nextval('"İnsan_ID_seq"'::regclass),
    "Ad-Soyad" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    "TelefonNo" character varying(10) COLLATE pg_catalog."default",
    "E-posta" character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT "İnsan_pkey" PRIMARY KEY ("ID"),
    CONSTRAINT unique_insan UNIQUE ("ID"),
    CONSTRAINT "İnsanTelefonNoUnique" UNIQUE ("TelefonNo")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."İnsan"
    OWNER to postgres;