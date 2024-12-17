-- Table: public.Sahiplik

-- DROP TABLE IF EXISTS public."Sahiplik";

CREATE TABLE IF NOT EXISTS public."Sahiplik"
(
    "SahiplikKaydı" integer NOT NULL,
    "SahipID" integer NOT NULL,
    "HayvanID" integer NOT NULL,
    CONSTRAINT "Sahiplik_pkey" PRIMARY KEY ("SahiplikKaydı"),
    CONSTRAINT "Sahiplik_HayvanID_fkey" FOREIGN KEY ("HayvanID")
        REFERENCES public."Hayvan" ("HayvanID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Sahiplik_SahipID_fkey" FOREIGN KEY ("SahipID")
        REFERENCES public."Sahip" ("ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Sahiplik"
    OWNER to postgres;