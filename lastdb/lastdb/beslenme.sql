-- Table: public.Beslenme

-- DROP TABLE IF EXISTS public."Beslenme";

CREATE TABLE IF NOT EXISTS public."Beslenme"
(
    "HayvanID" integer NOT NULL,
    "VerilmeZamanı" date NOT NULL,
    "Miktar" integer NOT NULL,
    CONSTRAINT "Beslenme_HayvanID_fkey" FOREIGN KEY ("HayvanID")
        REFERENCES public."Hayvan" ("HayvanID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Beslenme"
    OWNER to postgres;