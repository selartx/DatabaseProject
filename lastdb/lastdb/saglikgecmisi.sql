-- FUNCTION: public.saglik_gecmisi(integer)

-- DROP FUNCTION IF EXISTS public.saglik_gecmisi(integer);

CREATE OR REPLACE FUNCTION public.saglik_gecmisi(
	hayvan_id integer)
    RETURNS TABLE("KayıtID" integer, "HayvanID" integer, "Tarih" date, "SağlıkDurumu" text, "VeterinerID" integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        "Sağlık_Kaydı"."KayıtID", 
        "Sağlık_Kaydı"."HayvanID",
        "Sağlık_Kaydı"."Tarih",
        "Sağlık_Kaydı"."SağlıkDurumu"::text,  -- Explicitly cast to text
        "Sağlık_Kaydı"."VeterinerID"
    FROM "Sağlık_Kaydı"
    WHERE "Sağlık_Kaydı"."HayvanID" = hayvan_id;
END;
$BODY$;

ALTER FUNCTION public.saglik_gecmisi(integer)
    OWNER TO postgres;
