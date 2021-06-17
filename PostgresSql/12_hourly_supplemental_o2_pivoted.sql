DO
$do$
BEGIN
   IF  EXISTS (SELECT FROM public.hourly_supplemental_o2_pivoted) THEN
        DROP TABLE public.hourly_supplemental_o2_pivoted;
    END IF;
END
$do$;
CREATE TABLE public.hourly_supplemental_o2_pivoted as

SELECT 
subject_id,
hadm_id,
stay_id,
chart_hour,
AVG(CASE WHEN label in('Inspired O2 Fraction') THEN value END) as FiO2,
AVG(CASE WHEN label in ('O2 Flow') THEN value END) as O2_flow_rate
FROM hourly_supplemental_o2_flat
GROUP BY subject_id, hadm_id, stay_id, chart_hour
