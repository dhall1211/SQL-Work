/* Formatted on 1/9/2018 8:54:18 AM (QP5 v5.256.13226.35510) */
  SELECT *
    FROM (SELECT sch.schedule_date,
                 sch.ldc_duns,
                 NVL (sch.schedule_day_ahead, 0) schedule_day_ahead
            FROM schedules sch
           WHERE     SCH.GROUP_ID = '102'
                 AND SCH.SCHEDULE_DATE BETWEEN :start_date AND :end_Date
                 AND SCH.REPLACED IS NULL
                 AND SCH.LDC_DUNS IN ('JAPAN0003',
                                      'JAPAN0004',
                                      'JAPAN0006',
                                      'JAPAN0009')) PIVOT (SUM (
                                                              schedule_day_ahead)
                                                    FOR ldc_duns
                                                    IN  ('JAPAN0003' AS TEPCO,
                                                        'JAPAN0004' AS CHUBU,
                                                        'JAPAN0006' AS KANSAI,
                                                        'JAPAN0009' AS KYUSHU))
ORDER BY schedule_date;
