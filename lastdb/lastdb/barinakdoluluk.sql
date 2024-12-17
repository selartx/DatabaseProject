-- FUNCTION: public.barinak_doluluk(integer)

-- DROP FUNCTION IF EXISTS public.barinak_doluluk(integer);

CREATE OR REPLACE FUNCTION public.barinak_doluluk(
	barinak_id integer)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    doluluk_orani NUMERIC;  
    total_hayvan INT;      
    barinak_kapasite INT;    
BEGIN
    SELECT "Kapasite" INTO barinak_kapasite
    FROM "Barinaklar"
    WHERE "BarinakID" = barinak_id;

    SELECT COUNT(*) INTO total_hayvan
    FROM "Hayvan"
    WHERE "KonakNo" IN (SELECT "KonakNo" FROM "Konaklama" WHERE "BarinakID" = barinak_id);

    IF barinak_kapasite > 0 THEN
        doluluk_orani := (total_hayvan * 100.0) / barinak_kapasite;
    ELSE
        doluluk_orani := 0;
    END IF;

    RETURN doluluk_orani;
END;
$BODY$;

ALTER FUNCTION public.barinak_doluluk(integer)
    OWNER TO postgres;
