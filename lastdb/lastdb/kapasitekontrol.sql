-- FUNCTION: public.kapasite_kontrol(integer)

-- DROP FUNCTION IF EXISTS public.kapasite_kontrol(integer);

CREATE OR REPLACE FUNCTION public.kapasite_kontrol(
	barinak_id integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    mevcut_doluluk INT;
    barinak_kapasite INT;
BEGIN
    SELECT COUNT(*) INTO mevcut_doluluk
    FROM public."Konaklama"
    WHERE "BarinakID" = barinak_id AND "KonakDurum"='Dolu';

    SELECT "Kapasite" INTO barinak_kapasite
    FROM public."Barinaklar"
    WHERE "BarinakID" = barinak_id;

    IF mevcut_doluluk >= barinak_kapasite THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE; 
END;
$BODY$;

ALTER FUNCTION public.kapasite_kontrol(integer)
    OWNER TO postgres;
