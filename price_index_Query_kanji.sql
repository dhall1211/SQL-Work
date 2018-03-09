SELECT CASE SSPI.INDEX_NAME
            WHEN 'JEPX AC SPOT' THEN 'JEPX 回避可能原価'
            WHEN 'JEPX DA SPOT' THEN 'JEPX エリアプライス'
            WHEN 'スポット・時間前平均価格(円/kWh)' THEN 'スポット・時間前平均価格(円/kWh)'
            WHEN 'α上限値×スポット・時間前平均価格(円/kWh)' THEN 'α上限値×スポット・時間前平均価格(円/kWh)'
            WHEN 'α下限値×スポット・時間前平均価格(円/kWh)' THEN 'α下限値×スポット・時間前平均価格(円/kWh)'
            WHEN 'α速報値×スポット・時間前平均価格(円/kWh)' THEN 'α速報値×スポット・時間前平均価格(円/kWh)'
            WHEN 'α確報値×スポット・時間前平均価格(円/kWh)' THEN 'α確報値×スポット・時間前平均価格(円/kWh)'
         END
            AS INDEX_NAME,
         CASE SSPI.REGION
            WHEN 'HOKKAIDO' THEN '北海道'
            WHEN 'TOHOKU' THEN '東北'
            WHEN 'TOKYO' THEN '東京'
            WHEN 'CYUBU' THEN '中部'
            WHEN 'HOKURIKU' THEN '北陸'
            WHEN 'KANSAI' THEN '関西'
            WHEN 'CYUGOKU' THEN '中国'
            WHEN 'SHIKOKU' THEN '四国'
            WHEN 'KYUSYU' THEN '九州'
            WHEN 'ALL JAPAN' THEN '全国'
         END
            AS REGION,
         SSPI.INDEX_DATE,
         SSPI.INDEX_TIME,
         SSPI.INDEX_VALUE,
         SSRZ.SORT_ORDER
    FROM esg_trx2.ss_price_indexes SSPI, ss.SS_REGION_ZONE_TRANSLATION SSRZ
  WHERE SSPI.REGION = SSRZ.REGION
   AND SSPI.INDEX_DATE BETWEEN :start_date AND :end_date
   
ORDER BY 1, 6, 3, 4

