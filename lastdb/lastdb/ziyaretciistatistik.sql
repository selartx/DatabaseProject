-- FUNCTION: public.ziyaretci_istatistikleri()

-- DROP FUNCTION IF EXISTS public.ziyaretci_istatistikleri();

CREATE OR REPLACE FUNCTION public.ziyaretci_istatistikleri(
	)
    RETURNS TABLE(ziyaretci_turu character varying, toplam_sayi integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        "ZiyaretçiTürü", 
        COUNT(*)::INTEGER AS toplam_sayi
    FROM 
        public."Ziyaretçi"
    GROUP BY 
        "ZiyaretçiTürü";
END;
$BODY$;

ALTER FUNCTION public.ziyaretci_istatistikleri()
    OWNER TO postgres;
