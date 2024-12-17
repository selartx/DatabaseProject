-- FUNCTION: public.kapasite_kontrol_trigger()

-- DROP FUNCTION IF EXISTS public.kapasite_kontrol_trigger();

CREATE OR REPLACE FUNCTION public.kapasite_kontrol_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF NOT public.kapasite_kontrol(NEW."BarinakID") THEN
        RAISE EXCEPTION 'Barınak kapasitesi dolu. Yeni hayvan eklenemez.';
    END IF;

    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.kapasite_kontrol_trigger()
    OWNER TO postgres;
