/* Formatted on 2/14/2019 6:16:45 AM (QP5 v5.256.13226.35510) */
WITH cg_wp_forecast
     AS (SELECT org.NAME, org.duns, wpf.*
           FROM ss.ss_organization org,
                ss.SS_RSP_ORG_REL rel,
                ss.ss_group grp,
                ss.wesportal_forecast wpf
          WHERE     org.duns = grp.esp_duns
                AND grp.GROUP_ID = wpf.opportunity_id
                -- and wpf.opportunity_id = rel.rsp_group_id
                -- AND grp.GROUP_ID = rel.rsp_group_id
                AND grp.GROUP_ID = :GROUP_ID
                --(SELECT rel.rsp_Child_group_id
                --   FROM SS.SS_RSP_ORG_REL rel
                --  WHERE rel.RSP_GROUP_ID = grp.GROUP_ID)
                AND wpf.ldc_duns = :ldc_duns
                AND wpf.forecast_date BETWEEN :start_date AND :end_date),
     forecast_expanded
     AS (SELECT NAME,
                duns,
                ldc_name,
                ldc_duns,
                iso_ctrl_area,
                congestion_zone,
                forecast_date,
                opportunity_id,
                interval,
                val
           FROM cg_wp_forecast UNPIVOT INCLUDE NULLS (VAL
                               FOR (interval)
                               IN  (KWH_0030 AS '0:00-0:30',
                                   KWH_0100 AS '0:30-1:00',
                                   KWH_0130 AS '1:00-1:30',
                                   KWH_0200 AS '1:30-2:00',
                                   KWH_0230 AS '2:00-2:30',
                                   KWH_0300 AS '2:30-3:00',
                                   KWH_0330 AS '3:00-3:30',
                                   KWH_0400 AS '3:30-4:00',
                                   KWH_0430 AS '4:00-4:30',
                                   KWH_0500 AS '4:30-5:00',
                                   KWH_0530 AS '5:00-5:30',
                                   KWH_0600 AS '5:30-6:00',
                                   KWH_0630 AS '6:00-6:30',
                                   KWH_0700 AS '6:30-7:00',
                                   KWH_0730 AS '7:00-7:30',
                                   KWH_0800 AS '7:30-8:00',
                                   KWH_0830 AS '8:00-8:30',
                                   KWH_0900 AS '8:30-9:00',
                                   KWH_0930 AS '9:00-9:30',
                                   KWH_1000 AS '9:30-10:00',
                                   KWH_1030 AS '10:00-10:30',
                                   KWH_1100 AS '10:30-11:00',
                                   KWH_1130 AS '11:00-11:30',
                                   KWH_1200 AS '11:30-12:00',
                                   KWH_1230 AS '12:00-12:30',
                                   KWH_1300 AS '12:30-13:00',
                                   KWH_1330 AS '13:00-13:30',
                                   KWH_1400 AS '13:30-14:00',
                                   KWH_1430 AS '14:00-14:30',
                                   KWH_1500 AS '14:30-15:00',
                                   KWH_1530 AS '15:00-15:30',
                                   KWH_1600 AS '15:30-16:00',
                                   KWH_1630 AS '16:00-16:30',
                                   KWH_1700 AS '16:30-17:00',
                                   KWH_1730 AS '17:00-17:30',
                                   KWH_1800 AS '17:30-18:00',
                                   KWH_1830 AS '18:00-18:30',
                                   KWH_1900 AS '18:30-19:00',
                                   KWH_1930 AS '19:00-19:30',
                                   KWH_2000 AS '19:30-20:00',
                                   KWH_2030 AS '20:00-20:30',
                                   KWH_2100 AS '20:30-21:00',
                                   KWH_2130 AS '21:00-21:30',
                                   KWH_2200 AS '21:30-22:00',
                                   KWH_2230 AS '22:00-22:30',
                                   KWH_2300 AS '22:30-23:00',
                                   KWH_2330 AS '23:00-23:30',
                                   KWH_2400 AS '23:30-24:00'))),
     td_usage
     AS (  SELECT GROUP_ID,
                  idr_date,
                  SUM (ADJ_IE_0030) IE_0030,
                  SUM (ADJ_IE_0100) IE_0100,
                  SUM (ADJ_IE_0130) IE_0130,
                  SUM (ADJ_IE_0200) IE_0200,
                  SUM (ADJ_IE_0230) IE_0230,
                  SUM (ADJ_IE_0300) IE_0300,
                  SUM (ADJ_IE_0330) IE_0330,
                  SUM (ADJ_IE_0400) IE_0400,
                  SUM (ADJ_IE_0430) IE_0430,
                  SUM (ADJ_IE_0500) IE_0500,
                  SUM (ADJ_IE_0530) IE_0530,
                  SUM (ADJ_IE_0600) IE_0600,
                  SUM (ADJ_IE_0630) IE_0630,
                  SUM (ADJ_IE_0700) IE_0700,
                  SUM (ADJ_IE_0730) IE_0730,
                  SUM (ADJ_IE_0800) IE_0800,
                  SUM (ADJ_IE_0830) IE_0830,
                  SUM (ADJ_IE_0900) IE_0900,
                  SUM (ADJ_IE_0930) IE_0930,
                  SUM (ADJ_IE_1000) IE_1000,
                  SUM (ADJ_IE_1030) IE_1030,
                  SUM (ADJ_IE_1100) IE_1100,
                  SUM (ADJ_IE_1130) IE_1130,
                  SUM (ADJ_IE_1200) IE_1200,
                  SUM (ADJ_IE_1230) IE_1230,
                  SUM (ADJ_IE_1300) IE_1300,
                  SUM (ADJ_IE_1330) IE_1330,
                  SUM (ADJ_IE_1400) IE_1400,
                  SUM (ADJ_IE_1430) IE_1430,
                  SUM (ADJ_IE_1500) IE_1500,
                  SUM (ADJ_IE_1530) IE_1530,
                  SUM (ADJ_IE_1600) IE_1600,
                  SUM (ADJ_IE_1630) IE_1630,
                  SUM (ADJ_IE_1700) IE_1700,
                  SUM (ADJ_IE_1730) IE_1730,
                  SUM (ADJ_IE_1800) IE_1800,
                  SUM (ADJ_IE_1830) IE_1830,
                  SUM (ADJ_IE_1900) IE_1900,
                  SUM (ADJ_IE_1930) IE_1930,
                  SUM (ADJ_IE_2000) IE_2000,
                  SUM (ADJ_IE_2030) IE_2030,
                  SUM (ADJ_IE_2100) IE_2100,
                  SUM (ADJ_IE_2130) IE_2130,
                  SUM (ADJ_IE_2200) IE_2200,
                  SUM (ADJ_IE_2230) IE_2230,
                  SUM (ADJ_IE_2300) IE_2300,
                  SUM (ADJ_IE_2330) IE_2330,
                  SUM (ADJ_IE_2400) IE_2400
             FROM (  SELECT ge.GROUP_ID,
                            IDR.SS_ACCT_ID,
                            idr.idr_date,
                            laf.load_adjust_code,
                            laf.load_adjust_factor,
                            SUM (idr.IE_0030) IE_0030,
                            ROUND (
                               SUM (idr.IE_0030 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0030,
                            SUM (idr.IE_0100) IE_0100,
                            ROUND (
                               SUM (idr.IE_0100 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0100,
                            SUM (idr.IE_0130) IE_0130,
                            ROUND (
                               SUM (idr.IE_0130 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0130,
                            SUM (idr.IE_0200) IE_0200,
                            ROUND (
                               SUM (idr.IE_0200 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0200,
                            SUM (idr.IE_0230) IE_0230,
                            ROUND (
                               SUM (idr.IE_0230 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0230,
                            SUM (idr.IE_0300) IE_0300,
                            ROUND (
                               SUM (idr.IE_0300 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0300,
                            SUM (idr.IE_0330) IE_0330,
                            ROUND (
                               SUM (idr.IE_0330 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0330,
                            SUM (idr.IE_0400) IE_0400,
                            ROUND (
                               SUM (idr.IE_0400 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0400,
                            SUM (idr.IE_0430) IE_0430,
                            ROUND (
                               SUM (idr.IE_0430 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0430,
                            SUM (idr.IE_0500) IE_0500,
                            ROUND (
                               SUM (idr.IE_0500 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0500,
                            SUM (idr.IE_0530) IE_0530,
                            ROUND (
                               SUM (idr.IE_0530 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0530,
                            SUM (idr.IE_0600) IE_0600,
                            ROUND (
                               SUM (idr.IE_0600 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0600,
                            SUM (idr.IE_0630) IE_0630,
                            ROUND (
                               SUM (idr.IE_0630 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0630,
                            SUM (idr.IE_0700) IE_0700,
                            ROUND (
                               SUM (idr.IE_0700 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0700,
                            SUM (idr.IE_0730) IE_0730,
                            ROUND (
                               SUM (idr.IE_0730 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0730,
                            SUM (idr.IE_0800) IE_0800,
                            ROUND (
                               SUM (idr.IE_0800 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0800,
                            SUM (idr.IE_0830) IE_0830,
                            ROUND (
                               SUM (idr.IE_0830 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0830,
                            SUM (idr.IE_0900) IE_0900,
                            ROUND (
                               SUM (idr.IE_0900 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0900,
                            SUM (idr.IE_0930) IE_0930,
                            ROUND (
                               SUM (idr.IE_0930 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_0930,
                            SUM (idr.IE_1000) IE_1000,
                            ROUND (
                               SUM (idr.IE_1000 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1000,
                            SUM (idr.IE_1030) IE_1030,
                            ROUND (
                               SUM (idr.IE_1030 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1030,
                            SUM (idr.IE_1100) IE_1100,
                            ROUND (
                               SUM (idr.IE_1100 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1100,
                            SUM (idr.IE_1130) IE_1130,
                            ROUND (
                               SUM (idr.IE_1130 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1130,
                            SUM (idr.IE_1200) IE_1200,
                            ROUND (
                               SUM (idr.IE_1200 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1200,
                            SUM (idr.IE_1230) IE_1230,
                            ROUND (
                               SUM (idr.IE_1230 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1230,
                            SUM (idr.IE_1300) IE_1300,
                            ROUND (
                               SUM (idr.IE_1300 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1300,
                            SUM (idr.IE_1330) IE_1330,
                            ROUND (
                               SUM (idr.IE_1330 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1330,
                            SUM (idr.IE_1400) IE_1400,
                            ROUND (
                               SUM (idr.IE_1400 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1400,
                            SUM (idr.IE_1430) IE_1430,
                            ROUND (
                               SUM (idr.IE_1430 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1430,
                            SUM (idr.IE_1500) IE_1500,
                            ROUND (
                               SUM (idr.IE_1500 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1500,
                            SUM (idr.IE_1530) IE_1530,
                            ROUND (
                               SUM (idr.IE_1530 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1530,
                            SUM (idr.IE_1600) IE_1600,
                            ROUND (
                               SUM (idr.IE_1600 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1600,
                            SUM (idr.IE_1630) IE_1630,
                            ROUND (
                               SUM (idr.IE_1630 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1630,
                            SUM (idr.IE_1700) IE_1700,
                            ROUND (
                               SUM (idr.IE_1700 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1700,
                            SUM (idr.IE_1730) IE_1730,
                            ROUND (
                               SUM (idr.IE_1730 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1730,
                            SUM (idr.IE_1800) IE_1800,
                            ROUND (
                               SUM (idr.IE_1800 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1800,
                            SUM (idr.IE_1830) IE_1830,
                            ROUND (
                               SUM (idr.IE_1830 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1830,
                            SUM (idr.IE_1900) IE_1900,
                            ROUND (
                               SUM (idr.IE_1900 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1900,
                            SUM (idr.IE_1930) IE_1930,
                            ROUND (
                               SUM (idr.IE_1930 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_1930,
                            SUM (idr.IE_2000) IE_2000,
                            ROUND (
                               SUM (idr.IE_2000 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2000,
                            SUM (idr.IE_2030) IE_2030,
                            ROUND (
                               SUM (idr.IE_2030 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2030,
                            SUM (idr.IE_2100) IE_2100,
                            ROUND (
                               SUM (idr.IE_2100 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2100,
                            SUM (idr.IE_2130) IE_2130,
                            ROUND (
                               SUM (idr.IE_2130 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2130,
                            SUM (idr.IE_2200) IE_2200,
                            ROUND (
                               SUM (idr.IE_2200 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2200,
                            SUM (idr.IE_2230) IE_2230,
                            ROUND (
                               SUM (idr.IE_2230 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2230,
                            SUM (idr.IE_2300) IE_2300,
                            ROUND (
                               SUM (idr.IE_2300 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2300,
                            SUM (idr.IE_2330) IE_2330,
                            ROUND (
                               SUM (idr.IE_2330 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2330,
                            SUM (idr.IE_2400) IE_2400,
                            ROUND (
                               SUM (idr.IE_2400 / (1 - laf.load_adjust_factor)),
                               1)
                               ADJ_IE_2400
                       FROM cg_wp_forecast,
                            ss.ss_group_events ge,
                            ss.ss_event_log el,
                            ss.idrkh_IMBALANCE idr,
                            ss.ss_account ssa,
                            ss.ss_load_adjust_factors laf
                      WHERE     ge.event_id = el.event_id
                            AND ge.event_id = idr.event_id
                            AND ssa.ss_acct_id = idr.ss_acct_id
                            AND ssa.ldc_duns = laf.ldc_duns
                            AND SSA.CONGESTION_ZONE =
                                   cg_wp_forecast.CONGESTION_ZONE
                            AND ssa.line_loss_adjust_code = laf.load_adjust_code
                            AND cg_wp_forecast.opportunity_id = ge.GROUP_ID
                            AND cg_wp_forecast.forecast_date = idr.idr_date
                            AND el.event_desc = 'USGD'
                            AND idr.purp_code IN ('00', '05')
                            AND ssa.opp_start_date <=
                                   TO_CHAR (cg_wp_forecast.forecast_date,
                                            'YYYYMMDD')
                            AND (   ssa.opp_end_date IS NULL
                                 OR ssa.opp_end_date >
                                       TO_CHAR (cg_wp_forecast.forecast_date,
                                                'YYYYMMDD'))
                            AND idr.replace_event_id IS NULL
                            AND laf.version = 'S'
                   GROUP BY ge.GROUP_ID,
                            IDR.SS_ACCT_ID,
                            idr.idr_date,
                            laf.load_adjust_code,
                            laf.load_adjust_factor)
         GROUP BY GROUP_ID, idr_date),
     td_usage_expanded
     AS (SELECT idr_date,
                GROUP_ID,
                interval,
                val
           FROM td_usage UNPIVOT INCLUDE NULLS (VAL
                         FOR (interval)
                         IN  (IE_0030 AS '0:00-0:30',
                             IE_0100 AS '0:30-1:00',
                             IE_0130 AS '1:00-1:30',
                             IE_0200 AS '1:30-2:00',
                             IE_0230 AS '2:00-2:30',
                             IE_0300 AS '2:30-3:00',
                             IE_0330 AS '3:00-3:30',
                             IE_0400 AS '3:30-4:00',
                             IE_0430 AS '4:00-4:30',
                             IE_0500 AS '4:30-5:00',
                             IE_0530 AS '5:00-5:30',
                             IE_0600 AS '5:30-6:00',
                             IE_0630 AS '6:00-6:30',
                             IE_0700 AS '6:30-7:00',
                             IE_0730 AS '7:00-7:30',
                             IE_0800 AS '7:30-8:00',
                             IE_0830 AS '8:00-8:30',
                             IE_0900 AS '8:30-9:00',
                             IE_0930 AS '9:00-9:30',
                             IE_1000 AS '9:30-10:00',
                             IE_1030 AS '10:00-10:30',
                             IE_1100 AS '10:30-11:00',
                             IE_1130 AS '11:00-11:30',
                             IE_1200 AS '11:30-12:00',
                             IE_1230 AS '12:00-12:30',
                             IE_1300 AS '12:30-13:00',
                             IE_1330 AS '13:00-13:30',
                             IE_1400 AS '13:30-14:00',
                             IE_1430 AS '14:00-14:30',
                             IE_1500 AS '14:30-15:00',
                             IE_1530 AS '15:00-15:30',
                             IE_1600 AS '15:30-16:00',
                             IE_1630 AS '16:00-16:30',
                             IE_1700 AS '16:30-17:00',
                             IE_1730 AS '17:00-17:30',
                             IE_1800 AS '17:30-18:00',
                             IE_1830 AS '18:00-18:30',
                             IE_1900 AS '18:30-19:00',
                             IE_1930 AS '19:00-19:30',
                             IE_2000 AS '19:30-20:00',
                             IE_2030 AS '20:00-20:30',
                             IE_2100 AS '20:30-21:00',
                             IE_2130 AS '21:00-21:30',
                             IE_2200 AS '21:30-22:00',
                             IE_2230 AS '22:00-22:30',
                             IE_2300 AS '22:30-23:00',
                             IE_2330 AS '23:00-23:30',
                             IE_2400 AS '23:30-24:00'))),
     proc_plan
     AS (  SELECT ge.GROUP_ID,
                  pp.plan_seq,
                  pp.operating_date,
                  pp.plan_level,
                  pp.plan_item,
                  pp.plan_type,
                  SUM (pp.IE_0030) IE_0030,
                  SUM (pp.IE_0100) IE_0100,
                  SUM (pp.IE_0130) IE_0130,
                  SUM (pp.IE_0200) IE_0200,
                  SUM (pp.IE_0230) IE_0230,
                  SUM (pp.IE_0300) IE_0300,
                  SUM (pp.IE_0330) IE_0330,
                  SUM (pp.IE_0400) IE_0400,
                  SUM (pp.IE_0430) IE_0430,
                  SUM (pp.IE_0500) IE_0500,
                  SUM (pp.IE_0530) IE_0530,
                  SUM (pp.IE_0600) IE_0600,
                  SUM (pp.IE_0630) IE_0630,
                  SUM (pp.IE_0700) IE_0700,
                  SUM (pp.IE_0730) IE_0730,
                  SUM (pp.IE_0800) IE_0800,
                  SUM (pp.IE_0830) IE_0830,
                  SUM (pp.IE_0900) IE_0900,
                  SUM (pp.IE_0930) IE_0930,
                  SUM (pp.IE_1000) IE_1000,
                  SUM (pp.IE_1030) IE_1030,
                  SUM (pp.IE_1100) IE_1100,
                  SUM (pp.IE_1130) IE_1130,
                  SUM (pp.IE_1200) IE_1200,
                  SUM (pp.IE_1230) IE_1230,
                  SUM (pp.IE_1300) IE_1300,
                  SUM (pp.IE_1330) IE_1330,
                  SUM (pp.IE_1400) IE_1400,
                  SUM (pp.IE_1430) IE_1430,
                  SUM (pp.IE_1500) IE_1500,
                  SUM (pp.IE_1530) IE_1530,
                  SUM (pp.IE_1600) IE_1600,
                  SUM (pp.IE_1630) IE_1630,
                  SUM (pp.IE_1700) IE_1700,
                  SUM (pp.IE_1730) IE_1730,
                  SUM (pp.IE_1800) IE_1800,
                  SUM (pp.IE_1830) IE_1830,
                  SUM (pp.IE_1900) IE_1900,
                  SUM (pp.IE_1930) IE_1930,
                  SUM (pp.IE_2000) IE_2000,
                  SUM (pp.IE_2030) IE_2030,
                  SUM (pp.IE_2100) IE_2100,
                  SUM (pp.IE_2130) IE_2130,
                  SUM (pp.IE_2200) IE_2200,
                  SUM (pp.IE_2230) IE_2230,
                  SUM (pp.IE_2300) IE_2300,
                  SUM (pp.IE_2330) IE_2330,
                  SUM (pp.IE_2400) IE_2400
             FROM cg_wp_forecast,
                  ss.ss_group_events ge,
                  ss.procurement_plan pp,
                  ss.ss_region_zone_translation rz
            WHERE     ge.event_id = pp.event_id
                  AND cg_wp_forecast.opportunity_id = ge.GROUP_ID
                  AND cg_wp_forecast.forecast_date = pp.operating_date
                  AND cg_wp_forecast.ldc_duns = rz.index_2
                  AND rz.index_3 = pp.tp_code
                  AND PP.PLAN_SEQ = 1
                  AND PP.STATUS = 1
                  AND PP.PLAN_TYPE = 'DAILY'
                  AND PP.PLAN_TYPE <> 'GN'
         GROUP BY ge.GROUP_ID,
                  pp.plan_seq,
                  pp.operating_date,
                  pp.plan_level,
                  pp.plan_item,
                  pp.plan_type),
     proc_plan_expanded
     AS (SELECT operating_date,
                GROUP_ID,
                interval,
                val
           FROM proc_plan UNPIVOT INCLUDE NULLS (VAL
                          FOR (interval)
                          IN  (IE_0030 AS '0:00-0:30',
                              IE_0100 AS '0:30-1:00',
                              IE_0130 AS '1:00-1:30',
                              IE_0200 AS '1:30-2:00',
                              IE_0230 AS '2:00-2:30',
                              IE_0300 AS '2:30-3:00',
                              IE_0330 AS '3:00-3:30',
                              IE_0400 AS '3:30-4:00',
                              IE_0430 AS '4:00-4:30',
                              IE_0500 AS '4:30-5:00',
                              IE_0530 AS '5:00-5:30',
                              IE_0600 AS '5:30-6:00',
                              IE_0630 AS '6:00-6:30',
                              IE_0700 AS '6:30-7:00',
                              IE_0730 AS '7:00-7:30',
                              IE_0800 AS '7:30-8:00',
                              IE_0830 AS '8:00-8:30',
                              IE_0900 AS '8:30-9:00',
                              IE_0930 AS '9:00-9:30',
                              IE_1000 AS '9:30-10:00',
                              IE_1030 AS '10:00-10:30',
                              IE_1100 AS '10:30-11:00',
                              IE_1130 AS '11:00-11:30',
                              IE_1200 AS '11:30-12:00',
                              IE_1230 AS '12:00-12:30',
                              IE_1300 AS '12:30-13:00',
                              IE_1330 AS '13:00-13:30',
                              IE_1400 AS '13:30-14:00',
                              IE_1430 AS '14:00-14:30',
                              IE_1500 AS '14:30-15:00',
                              IE_1530 AS '15:00-15:30',
                              IE_1600 AS '15:30-16:00',
                              IE_1630 AS '16:00-16:30',
                              IE_1700 AS '16:30-17:00',
                              IE_1730 AS '17:00-17:30',
                              IE_1800 AS '17:30-18:00',
                              IE_1830 AS '18:00-18:30',
                              IE_1900 AS '18:30-19:00',
                              IE_1930 AS '19:00-19:30',
                              IE_2000 AS '19:30-20:00',
                              IE_2030 AS '20:00-20:30',
                              IE_2100 AS '20:30-21:00',
                              IE_2130 AS '21:00-21:30',
                              IE_2200 AS '21:30-22:00',
                              IE_2230 AS '22:00-22:30',
                              IE_2300 AS '22:30-23:00',
                              IE_2330 AS '23:00-23:30',
                              IE_2400 AS '23:30-24:00'))),
     wanted_sch
     AS (SELECT sch.GROUP_ID,
                sch.event_buyer_load_point_id,
                sch.ldc_duns,
                sch.congestion_zone,
                TO_DATE (sch.schedule_date, 'YYYYMMDD') schedule_date,
                CASE
                   WHEN sch.interval_time = '0030' THEN '0:00-0:30'
                   WHEN sch.interval_time = '0100' THEN '0:30-1:00'
                   WHEN sch.interval_time = '0130' THEN '1:00-1:30'
                   WHEN sch.interval_time = '0200' THEN '1:30-2:00'
                   WHEN sch.interval_time = '0230' THEN '2:00-2:30'
                   WHEN sch.interval_time = '0300' THEN '2:30-3:00'
                   WHEN sch.interval_time = '0330' THEN '3:00-3:30'
                   WHEN sch.interval_time = '0400' THEN '3:30-4:00'
                   WHEN sch.interval_time = '0430' THEN '4:00-4:30'
                   WHEN sch.interval_time = '0500' THEN '4:30-5:00'
                   WHEN sch.interval_time = '0530' THEN '5:00-5:30'
                   WHEN sch.interval_time = '0600' THEN '5:30-6:00'
                   WHEN sch.interval_time = '0630' THEN '6:00-6:30'
                   WHEN sch.interval_time = '0700' THEN '6:30-7:00'
                   WHEN sch.interval_time = '0730' THEN '7:00-7:30'
                   WHEN sch.interval_time = '0800' THEN '7:30-8:00'
                   WHEN sch.interval_time = '0830' THEN '8:00-8:30'
                   WHEN sch.interval_time = '0900' THEN '8:30-9:00'
                   WHEN sch.interval_time = '0930' THEN '9:00-9:30'
                   WHEN sch.interval_time = '1000' THEN '9:30-10:00'
                   WHEN sch.interval_time = '1030' THEN '10:00-10:30'
                   WHEN sch.interval_time = '1100' THEN '10:30-11:00'
                   WHEN sch.interval_time = '1130' THEN '11:00-11:30'
                   WHEN sch.interval_time = '1200' THEN '11:30-12:00'
                   WHEN sch.interval_time = '1230' THEN '12:00-12:30'
                   WHEN sch.interval_time = '1300' THEN '12:30-13:00'
                   WHEN sch.interval_time = '1330' THEN '13:00-13:30'
                   WHEN sch.interval_time = '1400' THEN '13:30-14:00'
                   WHEN sch.interval_time = '1430' THEN '14:00-14:30'
                   WHEN sch.interval_time = '1500' THEN '14:30-15:00'
                   WHEN sch.interval_time = '1530' THEN '15:00-15:30'
                   WHEN sch.interval_time = '1600' THEN '15:30-16:00'
                   WHEN sch.interval_time = '1630' THEN '16:00-16:30'
                   WHEN sch.interval_time = '1700' THEN '16:30-17:00'
                   WHEN sch.interval_time = '1730' THEN '17:00-17:30'
                   WHEN sch.interval_time = '1800' THEN '17:30-18:00'
                   WHEN sch.interval_time = '1830' THEN '18:00-18:30'
                   WHEN sch.interval_time = '1900' THEN '18:30-19:00'
                   WHEN sch.interval_time = '1930' THEN '19:00-19:30'
                   WHEN sch.interval_time = '2000' THEN '19:30-20:00'
                   WHEN sch.interval_time = '2030' THEN '20:00-20:30'
                   WHEN sch.interval_time = '2100' THEN '20:30-21:00'
                   WHEN sch.interval_time = '2130' THEN '21:00-21:30'
                   WHEN sch.interval_time = '2200' THEN '21:30-22:00'
                   WHEN sch.interval_time = '2230' THEN '22:00-22:30'
                   WHEN sch.interval_time = '2300' THEN '22:30-23:00'
                   WHEN sch.interval_time = '2330' THEN '23:00-23:30'
                   WHEN sch.interval_time = '2400' THEN '23:30-24:00'
                   ELSE NULL
                END
                   interval,
                schedule_mwh
           FROM cg_wp_forecast wf, ss.schedules sch
          WHERE     wf.opportunity_id = sch.GROUP_ID
                AND wf.ldc_duns = sch.ldc_duns
                AND wf.congestion_zone = sch.congestion_zone
                AND wf.forecast_date =
                       TO_DATE (sch.schedule_date, 'YYYYMMDD')
                AND sch.replaced IS NULL),
     GET_SPOT_BID
     AS (  SELECT CASE
                     WHEN CTR.SPOT_PROD_ID = '1' THEN '0:00-0:30'
                     WHEN CTR.SPOT_PROD_ID = '2' THEN '0:30-1:00'
                     WHEN CTR.SPOT_PROD_ID = '3' THEN '1:00-1:30'
                     WHEN CTR.SPOT_PROD_ID = '4' THEN '1:30-2:00'
                     WHEN CTR.SPOT_PROD_ID = '5' THEN '2:00-2:30'
                     WHEN CTR.SPOT_PROD_ID = '6' THEN '2:30-3:00'
                     WHEN CTR.SPOT_PROD_ID = '7' THEN '3:00-3:30'
                     WHEN CTR.SPOT_PROD_ID = '8' THEN '3:30-4:00'
                     WHEN CTR.SPOT_PROD_ID = '9' THEN '4:00-4:30'
                     WHEN CTR.SPOT_PROD_ID = '10' THEN '4:30-5:00'
                     WHEN CTR.SPOT_PROD_ID = '11' THEN '5:00-5:30'
                     WHEN CTR.SPOT_PROD_ID = '12' THEN '5:30-6:00'
                     WHEN CTR.SPOT_PROD_ID = '13' THEN '6:00-6:30'
                     WHEN CTR.SPOT_PROD_ID = '14' THEN '6:30-7:00'
                     WHEN CTR.SPOT_PROD_ID = '15' THEN '7:00-7:30'
                     WHEN CTR.SPOT_PROD_ID = '16' THEN '7:30-8:00'
                     WHEN CTR.SPOT_PROD_ID = '17' THEN '8:00-8:30'
                     WHEN CTR.SPOT_PROD_ID = '18' THEN '8:30-9:00'
                     WHEN CTR.SPOT_PROD_ID = '19' THEN '9:00-9:30'
                     WHEN CTR.SPOT_PROD_ID = '20' THEN '9:30-10:00'
                     WHEN CTR.SPOT_PROD_ID = '21' THEN '10:00-10:30'
                     WHEN CTR.SPOT_PROD_ID = '22' THEN '10:30-11:00'
                     WHEN CTR.SPOT_PROD_ID = '23' THEN '11:00-11:30'
                     WHEN CTR.SPOT_PROD_ID = '24' THEN '11:30-12:00'
                     WHEN CTR.SPOT_PROD_ID = '25' THEN '12:00-12:30'
                     WHEN CTR.SPOT_PROD_ID = '26' THEN '12:30-13:00'
                     WHEN CTR.SPOT_PROD_ID = '27' THEN '13:00-13:30'
                     WHEN CTR.SPOT_PROD_ID = '28' THEN '13:30-14:00'
                     WHEN CTR.SPOT_PROD_ID = '29' THEN '14:00-14:30'
                     WHEN CTR.SPOT_PROD_ID = '30' THEN '14:30-15:00'
                     WHEN CTR.SPOT_PROD_ID = '31' THEN '15:00-15:30'
                     WHEN CTR.SPOT_PROD_ID = '32' THEN '15:30-16:00'
                     WHEN CTR.SPOT_PROD_ID = '33' THEN '16:00-16:30'
                     WHEN CTR.SPOT_PROD_ID = '34' THEN '16:30-17:00'
                     WHEN CTR.SPOT_PROD_ID = '35' THEN '17:00-17:30'
                     WHEN CTR.SPOT_PROD_ID = '36' THEN '17:30-18:00'
                     WHEN CTR.SPOT_PROD_ID = '37' THEN '18:00-18:30'
                     WHEN CTR.SPOT_PROD_ID = '38' THEN '18:30-19:00'
                     WHEN CTR.SPOT_PROD_ID = '39' THEN '19:00-19:30'
                     WHEN CTR.SPOT_PROD_ID = '40' THEN '19:30-20:00'
                     WHEN CTR.SPOT_PROD_ID = '41' THEN '20:00-20:30'
                     WHEN CTR.SPOT_PROD_ID = '42' THEN '20:30-21:00'
                     WHEN CTR.SPOT_PROD_ID = '43' THEN '21:00-21:30'
                     WHEN CTR.SPOT_PROD_ID = '44' THEN '21:30-22:00'
                     WHEN CTR.SPOT_PROD_ID = '45' THEN '22:00-22:30'
                     WHEN CTR.SPOT_PROD_ID = '46' THEN '22:30-23:00'
                     WHEN CTR.SPOT_PROD_ID = '47' THEN '23:00-23:30'
                     WHEN CTR.SPOT_PROD_ID = '48' THEN '23:30-24:00'
                     ELSE NULL
                  END
                     interval,
                  Delivery_date,
                  SUM (contract_amount_1 * 500) AS JEPX_SPOT_BID
             FROM JEPX.GET_SPOT_CTRT_INV_HEADER HDR,
                  jepx.get_spot_ctrt_inv_detail ctr
            WHERE
                   BUY_SELL_TYPE = 2
                   AND AREA_ID = :Area_ID
                  AND  CTR.EVENT_ID = HDR.EVENT_ID
         GROUP BY delivery_date, contract_amount_1, spot_prod_id
         ORDER BY CTR.SPOT_PROD_ID ASC)
  SELECT forecast_expanded.name REU,
         forecast_expanded.ldc_name UTILITY,
         forecast_expanded.forecast_date OPERATING_DATE,
         forecast_expanded.interval,
         CAST (forecast_expanded.val AS INT) FORECASTED_AMOUNT,
         proc_plan_expanded.val DEMAND_PROCUREMENT,
         td_usage_expanded.val TD_ACTUAL_LOSS_ADJ,
         (forecast_expanded.val - proc_plan_expanded.val)
            AS SCHEDULED_IMBALANCE,
         GET_SPOT_BID.JEPX_SPOT_BID
    FROM forecast_expanded,
         td_usage_expanded,
         proc_plan_expanded,
         wanted_sch,
         GET_SPOT_BID
   WHERE     forecast_expanded.opportunity_id = td_usage_expanded.GROUP_ID(+)
         AND forecast_expanded.forecast_Date = get_spot_bid.delivery_date
         AND forecast_expanded.forecast_date = td_usage_expanded.idr_date(+)
         AND forecast_expanded.interval = td_usage_expanded.interval(+)
         AND forecast_expanded.interval = GET_SPOT_BID.interval(+)
         AND forecast_expanded.opportunity_id = proc_plan_expanded.GROUP_ID(+)
         AND forecast_expanded.forecast_date =
                proc_plan_expanded.operating_date(+)
         AND forecast_expanded.interval = proc_plan_expanded.interval(+)
         AND forecast_expanded.iso_ctrl_area = :iso_ctrl_area
GROUP BY forecast_expanded.name,
         forecast_expanded.ldc_name,
         forecast_expanded.forecast_date,
         forecast_expanded.interval,
         forecast_expanded.val,
         proc_plan_expanded.val,
         td_usage_expanded.val,
         GET_SPOT_BID.JEPX_SPOT_BID
ORDER BY forecast_expanded.name,
         forecast_expanded.ldc_name,
         forecast_expanded.forecast_date,
         CASE
            WHEN SUBSTR (forecast_expanded.interval, 0) = '0:00-0:30'
            THEN
               1
            WHEN SUBSTR (forecast_expanded.interval, 0) = '0:30-1:00'
            THEN
               2
            WHEN SUBSTR (forecast_expanded.interval, 0) = '1:00-1:30'
            THEN
               3
            WHEN SUBSTR (forecast_expanded.interval, 0) = '1:30-2:00'
            THEN
               4
            WHEN SUBSTR (forecast_expanded.interval, 0) = '2:00-2:30'
            THEN
               5
            WHEN SUBSTR (forecast_expanded.interval, 0) = '2:30-3:00'
            THEN
               6
            WHEN SUBSTR (forecast_expanded.interval, 0) = '3:00-3:30'
            THEN
               7
            WHEN SUBSTR (forecast_expanded.interval, 0) = '3:30-4:00'
            THEN
               8
            WHEN SUBSTR (forecast_expanded.interval, 0) = '4:00-4:30'
            THEN
               9
            WHEN SUBSTR (forecast_expanded.interval, 0) = '4:30-5:00'
            THEN
               10
            WHEN SUBSTR (forecast_expanded.interval, 0) = '5:00-5:30'
            THEN
               11
            WHEN SUBSTR (forecast_expanded.interval, 0) = '5:30-6:00'
            THEN
               12
            WHEN SUBSTR (forecast_expanded.interval, 0) = '6:00-6:30'
            THEN
               13
            WHEN SUBSTR (forecast_expanded.interval, 0) = '6:30-7:00'
            THEN
               14
            WHEN SUBSTR (forecast_expanded.interval, 0) = '7:00-7:30'
            THEN
               15
            WHEN SUBSTR (forecast_expanded.interval, 0) = '7:30-8:00'
            THEN
               16
            WHEN SUBSTR (forecast_expanded.interval, 0) = '8:00-8:30'
            THEN
               17
            WHEN SUBSTR (forecast_expanded.interval, 0) = '8:30-9:00'
            THEN
               18
            WHEN SUBSTR (forecast_expanded.interval, 0) = '9:00-9:30'
            THEN
               19
            WHEN SUBSTR (forecast_expanded.interval, 0) = '9:30-10:00'
            THEN
               20
            WHEN SUBSTR (forecast_expanded.interval, 0) = '10:00-10:30'
            THEN
               21
            WHEN SUBSTR (forecast_expanded.interval, 0) = '10:30-11:00'
            THEN
               22
            WHEN SUBSTR (forecast_expanded.interval, 0) = '11:00-11:30'
            THEN
               23
            WHEN SUBSTR (forecast_expanded.interval, 0) = '11:30-12:00'
            THEN
               24
            WHEN SUBSTR (forecast_expanded.interval, 0) = '12:00-12:30'
            THEN
               25
            WHEN SUBSTR (forecast_expanded.interval, 0) = '12:30-13:00'
            THEN
               26
            WHEN SUBSTR (forecast_expanded.interval, 0) = '13:00-13:30'
            THEN
               27
            WHEN SUBSTR (forecast_expanded.interval, 0) = '13:30-14:00'
            THEN
               28
            WHEN SUBSTR (forecast_expanded.interval, 0) = '14:00-14:30'
            THEN
               29
            WHEN SUBSTR (forecast_expanded.interval, 0) = '14:30-15:00'
            THEN
               30
            WHEN SUBSTR (forecast_expanded.interval, 0) = '15:00-15:30'
            THEN
               31
            WHEN SUBSTR (forecast_expanded.interval, 0) = '15:30-16:00'
            THEN
               32
            WHEN SUBSTR (forecast_expanded.interval, 0) = '16:00-16:30'
            THEN
               33
            WHEN SUBSTR (forecast_expanded.interval, 0) = '16:30-17:00'
            THEN
               34
            WHEN SUBSTR (forecast_expanded.interval, 0) = '17:00-17:30'
            THEN
               35
            WHEN SUBSTR (forecast_expanded.interval, 0) = '17:30-18:00'
            THEN
               36
            WHEN SUBSTR (forecast_expanded.interval, 0) = '18:00-18:30'
            THEN
               37
            WHEN SUBSTR (forecast_expanded.interval, 0) = '18:30-19:00'
            THEN
               38
            WHEN SUBSTR (forecast_expanded.interval, 0) = '19:00-19:30'
            THEN
               39
            WHEN SUBSTR (forecast_expanded.interval, 0) = '19:30-20:00'
            THEN
               40
            WHEN SUBSTR (forecast_expanded.interval, 0) = '20:00-20:30'
            THEN
               41
            WHEN SUBSTR (forecast_expanded.interval, 0) = '20:30-21:00'
            THEN
               42
            WHEN SUBSTR (forecast_expanded.interval, 0) = '21:00-21:30'
            THEN
               43
            WHEN SUBSTR (forecast_expanded.interval, 0) = '21:30-22:00'
            THEN
               44
            WHEN SUBSTR (forecast_expanded.interval, 0) = '22:00-22:30'
            THEN
               45
            WHEN SUBSTR (forecast_expanded.interval, 0) = '22:30-23:00'
            THEN
               46
            WHEN SUBSTR (forecast_expanded.interval, 0) = '23:00-23:30'
            THEN
               47
            WHEN SUBSTR (forecast_expanded.interval, 0) = '23:30-24:00'
            THEN
               48
         END;