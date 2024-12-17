-- Table: public.Ziyaretçi

-- DROP TABLE IF EXISTS public."Ziyaretçi";

CREATE TABLE IF NOT EXISTS public."Ziyaretçi"
(
    -- Inherited from table public."İnsan": "ID" integer NOT NULL DEFAULT nextval('"İnsan_ID_seq"'::regclass),
    -- Inherited from table public."İnsan": "Ad-Soyad" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    -- Inherited from table public."İnsan": "TelefonNo" character varying(10) COLLATE pg_catalog."default",
    -- Inherited from table public."İnsan": "E-posta" character varying(100) COLLATE pg_catalog."default",
    "ZiyaretTarihi" date NOT NULL,
    "ZiyaretçiTürü" character varying(50) COLLATE pg_catalog."default" DEFAULT 'Ziyaretçi'::character varying,
    CONSTRAINT "ZiyaretçiID" PRIMARY KEY ("ID"),
    CONSTRAINT "TelefonNoUnique" UNIQUE ("TelefonNo")
)
    INHERITS (public."İnsan")

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Ziyaretçi"
    OWNER to postgres;