-- FUNCTION: public.total_bagis()

-- DROP FUNCTION IF EXISTS public.total_bagis();

CREATE OR REPLACE FUNCTION public.total_bagis()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    UPDATE "Barinaklar"
    SET "Kasa" = (
        SELECT SUM("BagisMiktari")
        FROM "Bagislar"
        WHERE "Bagislar"."BarinakID" = NEW."BarinakID"
    )
    WHERE "Barinaklar"."BarinakID" = NEW."BarinakID";

    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.total_bagis()
    OWNER TO postgres;
