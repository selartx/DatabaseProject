-- Table: public.Sağlık_Kaydı

-- DROP TABLE IF EXISTS public."Sağlık_Kaydı";

CREATE TABLE IF NOT EXISTS public."Sağlık_Kaydı"
(
    "KayıtID" integer NOT NULL DEFAULT nextval('saglikkaydi_kayitid_seq'::regclass),
    "HayvanID" integer NOT NULL,
    "VeterinerID" integer NOT NULL,
    "Tarih" date NOT NULL,
    "SağlıkDurumu" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Sağlık_Kaydı_pkey" PRIMARY KEY ("KayıtID"),
    CONSTRAINT "HayvanID" FOREIGN KEY ("HayvanID")
        REFERENCES public."Hayvan" ("HayvanID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "Sağlık_Kaydı_VeterinerID_fkey" FOREIGN KEY ("VeterinerID")
        REFERENCES public."Veteriner" ("ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Sağlık_Kaydı"
    OWNER to postgres;

-- Trigger: saglikkaydi_trigger

-- DROP TRIGGER IF EXISTS saglikkaydi_trigger ON public."Sağlık_Kaydı";

CREATE OR REPLACE TRIGGER saglikkaydi_trigger
    AFTER INSERT
    ON public."Sağlık_Kaydı"
    FOR EACH ROW
    EXECUTE FUNCTION public.saglikkaydi_trigger();