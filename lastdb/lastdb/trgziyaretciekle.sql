-- FUNCTION: public.insert_ziyaretci()

-- DROP FUNCTION IF EXISTS public.insert_ziyaretci();

CREATE OR REPLACE FUNCTION public.insert_ziyaretci()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF NEW."ZiyaretTarihi" IS NOT NULL AND 
       NOT EXISTS (SELECT 1 FROM public."Ziyaretçi" WHERE "ID" = NEW."ID") THEN
        INSERT INTO public."Ziyaretçi"(
            "ID", 
            "Ad-Soyad", 
            "TelefonNo", 
            "E-posta", 
            "ZiyaretTarihi", 
            "ZiyaretçiTürü"
        )
        VALUES (
            NEW."ID", 
            NEW."Ad-Soyad", 
            NEW."TelefonNo", 
            NEW."E-posta", 
            NEW."ZiyaretTarihi", 
            CASE TG_TABLE_NAME
                WHEN 'Gönüllü' THEN 'Gönüllü'
                WHEN 'Sahip' THEN 'Sahip'
                WHEN 'Veteriner' THEN 'Veteriner'
                ELSE 'Ziyaretçi'
            END
        );
    END IF;
    RETURN NULL;
END;
$BODY$;

ALTER FUNCTION public.insert_ziyaretci()
    OWNER TO postgres;
