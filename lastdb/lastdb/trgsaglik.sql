-- FUNCTION: public.saglikkaydi_trigger()

-- DROP FUNCTION IF EXISTS public.saglikkaydi_trigger();

CREATE OR REPLACE FUNCTION public.saglikkaydi_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    son_saglik_durumu TEXT;
BEGIN
    IF NEW."SağlıkDurumu" IS NOT NULL THEN
        SELECT "SağlıkDurumu"
        INTO son_saglik_durumu
        FROM public."Sağlık_Kaydı"
        WHERE "HayvanID" = NEW."HayvanID"
        ORDER BY "Tarih" DESC
        LIMIT 1;

        IF son_saglik_durumu IS NOT NULL THEN
            UPDATE public."Hayvan"
            SET "SağlıkDurumu" = son_saglik_durumu
            WHERE "HayvanID" = NEW."HayvanID";
        ELSE
            UPDATE public."Hayvan"
            SET "SağlıkDurumu" = 'Bulunamadı'
            WHERE "HayvanID" = NEW."HayvanID";
        END IF;
    ELSE
        UPDATE public."Hayvan"
        SET "SağlıkDurumu" = 'Bulunamadı'
        WHERE "HayvanID" = NEW."HayvanID";
    END IF;

    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.saglikkaydi_trigger()
    OWNER TO postgres;
