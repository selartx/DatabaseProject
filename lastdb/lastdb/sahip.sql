-- Table: public.Sahip

-- DROP TABLE IF EXISTS public."Sahip";

CREATE TABLE IF NOT EXISTS public."Sahip"
(
    -- Inherited from table public."Ziyaretçi": "ID" integer NOT NULL DEFAULT nextval('"İnsan_ID_seq"'::regclass),
    -- Inherited from table public."Ziyaretçi": "Ad-Soyad" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    -- Inherited from table public."Ziyaretçi": "TelefonNo" character varying(10) COLLATE pg_catalog."default",
    -- Inherited from table public."Ziyaretçi": "E-posta" character varying(100) COLLATE pg_catalog."default",
    -- Inherited from table public."Ziyaretçi": "ZiyaretTarihi" date NOT NULL,
    -- Inherited from table public."Ziyaretçi": "ZiyaretçiTürü" character varying(50) COLLATE pg_catalog."default" DEFAULT 'Sahip'::character varying,
    CONSTRAINT "Sahip_pkey" PRIMARY KEY ("ID"),
    CONSTRAINT "SahipTelefonNoUnique" UNIQUE ("TelefonNo")
)
    INHERITS (public."Ziyaretçi")

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Sahip"
    OWNER to postgres;

-- Trigger: trigger_sahip

-- DROP TRIGGER IF EXISTS trigger_sahip ON public."Sahip";

CREATE OR REPLACE TRIGGER trigger_sahip
    AFTER INSERT
    ON public."Sahip"
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_ziyaretci();