-- Table: public.Hayvan

-- DROP TABLE IF EXISTS public."Hayvan";

CREATE TABLE IF NOT EXISTS public."Hayvan"
(
    "HayvanID" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "HayvanTürü" character varying COLLATE pg_catalog."default",
    "Ad" character varying COLLATE pg_catalog."default",
    "KonakNo" integer,
    "BakıcıID" integer,
    "SahiplikDurumu" boolean,
    "SağlıkDurumu" character varying COLLATE pg_catalog."default" DEFAULT 'Bulunamadı'::character varying,
    CONSTRAINT "HayvanID" PRIMARY KEY ("HayvanID"),
    CONSTRAINT "BakıcıID" FOREIGN KEY ("BakıcıID")
        REFERENCES public."Bakici" ("ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "HayvanTuru" FOREIGN KEY ("HayvanTürü")
        REFERENCES public."Türler" ("TürAdı") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "KonakNo" FOREIGN KEY ("KonakNo")
        REFERENCES public."Konaklama" ("KonakNo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Hayvan"
    OWNER to postgres;

-- Trigger: kafes_durumu

-- DROP TRIGGER IF EXISTS kafes_durumu ON public."Hayvan";

CREATE OR REPLACE TRIGGER kafes_durumu
    AFTER UPDATE OF "SahiplikDurumu"
    ON public."Hayvan"
    FOR EACH ROW
    WHEN (old."SahiplikDurumu" IS DISTINCT FROM new."SahiplikDurumu")
    EXECUTE FUNCTION public.kafesdurumu_trigger();

-- Trigger: kafes_kontrol_tetikleyici

-- DROP TRIGGER IF EXISTS kafes_kontrol_tetikleyici ON public."Hayvan";

CREATE OR REPLACE TRIGGER kafes_kontrol_tetikleyici
    BEFORE INSERT
    ON public."Hayvan"
    FOR EACH ROW
    EXECUTE FUNCTION public.kafesdurumu_trigger();

-- Trigger: kafesdurumu_trigger

-- DROP TRIGGER IF EXISTS kafesdurumu_trigger ON public."Hayvan";

CREATE OR REPLACE TRIGGER kafesdurumu_trigger
    AFTER DELETE
    ON public."Hayvan"
    FOR EACH ROW
    EXECUTE FUNCTION public.kafesdurumu_trigger();