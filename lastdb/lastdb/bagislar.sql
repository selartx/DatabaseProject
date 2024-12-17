-- Table: public.Bagislar

-- DROP TABLE IF EXISTS public."Bagislar";

CREATE TABLE IF NOT EXISTS public."Bagislar"
(
    "BagisciID" integer NOT NULL,
    "BarinakID" integer NOT NULL,
    "BagisMiktari" integer NOT NULL,
    CONSTRAINT "BarınakID" FOREIGN KEY ("BarinakID")
        REFERENCES public."Barinaklar" ("BarinakID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "BağışçıID" FOREIGN KEY ("BagisciID")
        REFERENCES public."Bagisci" ("ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Bagislar"
    OWNER to postgres;

-- Trigger: total_bagis

-- DROP TRIGGER IF EXISTS total_bagis ON public."Bagislar";

CREATE OR REPLACE TRIGGER total_bagis
    AFTER INSERT OR UPDATE 
    ON public."Bagislar"
    FOR EACH ROW
    EXECUTE FUNCTION public.total_bagis();