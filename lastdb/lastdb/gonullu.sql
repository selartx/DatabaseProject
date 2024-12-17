-- Table: public.Gönüllü

-- DROP TABLE IF EXISTS public."Gönüllü";

CREATE TABLE IF NOT EXISTS public."Gönüllü"
(
    -- Inherited from table public."Ziyaretçi": "ID" integer NOT NULL DEFAULT nextval('"İnsan_ID_seq"'::regclass),
    -- Inherited from table public."Ziyaretçi": "Ad-Soyad" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    -- Inherited from table public."Ziyaretçi": "TelefonNo" character varying(10) COLLATE pg_catalog."default",
    -- Inherited from table public."Ziyaretçi": "E-posta" character varying(100) COLLATE pg_catalog."default",
    -- Inherited from table public."Ziyaretçi": "ZiyaretTarihi" date NOT NULL,
    -- Inherited from table public."Ziyaretçi": "ZiyaretçiTürü" character varying(50) COLLATE pg_catalog."default" DEFAULT 'Gönüllü'::character varying,
    CONSTRAINT "GönüllüID" PRIMARY KEY ("ID"),
    CONSTRAINT "GönüllüTelefonNoUnique" UNIQUE ("TelefonNo")
)
    INHERITS (public."Ziyaretçi")

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Gönüllü"
    OWNER to postgres;

-- Trigger: trg_insert_ziyaretci

-- DROP TRIGGER IF EXISTS trg_insert_ziyaretci ON public."Gönüllü";

CREATE OR REPLACE TRIGGER trg_insert_ziyaretci
    AFTER INSERT
    ON public."Gönüllü"
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_ziyaretci();