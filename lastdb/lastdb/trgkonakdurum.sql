-- FUNCTION: public.kafesdurumu_trigger()

-- DROP FUNCTION IF EXISTS public.kafesdurumu_trigger();

CREATE OR REPLACE FUNCTION public.kafesdurumu_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF (SELECT "KonakDurum" 
        FROM public."Konaklama"
        WHERE "KonakNo" = NEW."KonakNo") = 'Dolu' THEN
        RAISE EXCEPTION 'Kafes zaten dolu. Yeni hayvan eklenemez.';
    END IF;

    IF (SELECT "KonakDurum" 
        FROM public."Konaklama"
        WHERE "KonakNo" = NEW."KonakNo") = 'Boş' THEN
        UPDATE public."Konaklama"
        SET "KonakDurum" = 'Dolu'
        WHERE "KonakNo" = NEW."KonakNo";
    END IF;

    IF NEW."SahiplikDurumu" = true THEN
        UPDATE public."Konaklama"
        SET "KonakDurum" = 'Boş'
        WHERE "KonakNo" = NEW."KonakNo";

        UPDATE public."Hayvan"
        SET "KonakNo" = NULL
        WHERE "HayvanID" = NEW."HayvanID";
    END IF;

   
    IF NEW."SahiplikDurumu" IS NULL THEN
        NEW."SahiplikDurumu" := false;
    END IF;

    IF TG_OP = 'DELETE' THEN
        UPDATE public."Konaklama"
        SET "KonakDurum" = 'Boş'
        WHERE "KonakNo" = OLD."KonakNo";
    END IF;

    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.kafesdurumu_trigger()
    OWNER TO postgres;
