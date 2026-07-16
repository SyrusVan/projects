--------------------------- ML ---------------------------
DROP TABLE IF EXISTS ph_homo_group_${scheme_id}_training_set;
CREATE TABLE ph_homo_group_${scheme_id}_training_set LIFECYCLE 14 AS
SELECT  oneid
        ,age
        ,gender
        ,freq_city_tier
        ,freq_area
        ,profession
        ,education_degree
        ,consumption_level
        ,online_hours
        ,mobile_os
        ,mobile_price
        ,IF(is_active_30d IS NULL,0,is_active_30d) AS is_active_30d
        ,IF(is_active_15d IS NULL,0,is_active_15d) AS is_active_15d
        ,IF(is_active_7d IS NULL,0,is_active_7d) AS is_active_7d
        ,IF(view_cnt_30d IS NULL,0,view_cnt_30d) AS view_cnt_30d
        ,IF(collect_cnt_30d IS NULL,0,collect_cnt_30d) AS collect_cnt_30d
        ,IF(cart_cnt_30d IS NULL,0,cart_cnt_30d) AS cart_cnt_30d
        ,IF(ord_cnt_30d IS NULL,0,ord_cnt_30d) AS ord_cnt_30d
        ,IF(search_cnt_30d IS NULL,0,search_cnt_30d) AS search_cnt_30d
        ,IF(view_cnt_15d IS NULL,0,view_cnt_15d) AS view_cnt_15d
        ,IF(collect_cnt_15d IS NULL,0,collect_cnt_15d) AS collect_cnt_15d
        ,IF(cart_cnt_15d IS NULL,0,cart_cnt_15d) AS cart_cnt_15d
        ,IF(ord_cnt_15d IS NULL,0,ord_cnt_15d) AS ord_cnt_15d
        ,IF(search_cnt_15d IS NULL,0,search_cnt_15d) AS search_cnt_15d
        ,IF(view_cnt_7d IS NULL,0,view_cnt_7d) AS view_cnt_7d
        ,IF(collect_cnt_7d IS NULL,0,collect_cnt_7d) AS collect_cnt_7d
        ,IF(cart_cnt_7d IS NULL,0,cart_cnt_7d) AS cart_cnt_7d
        ,IF(ord_cnt_7d IS NULL,0,ord_cnt_7d) AS ord_cnt_7d
        ,IF(search_cnt_7d IS NULL,0,search_cnt_7d) AS search_cnt_7d
        ,is_expose
        ,label
FROM    dsc_sh_taobao_umeng_tfhwgg.ph_homo_group_expose_crowds_${scheme_id}
WHERE   rn <= 2000000
UNION ALL 
SELECT  oneid
        ,age
        ,gender
        ,freq_city_tier
        ,freq_area
        ,profession
        ,education_degree
        ,consumption_level
        ,online_hours
        ,mobile_os
        ,mobile_price
        ,IF(is_active_30d IS NULL,0,is_active_30d) AS is_active_30d
        ,IF(is_active_15d IS NULL,0,is_active_15d) AS is_active_15d
        ,IF(is_active_7d IS NULL,0,is_active_7d) AS is_active_7d
        ,IF(view_cnt_30d IS NULL,0,view_cnt_30d) AS view_cnt_30d
        ,IF(collect_cnt_30d IS NULL,0,collect_cnt_30d) AS collect_cnt_30d
        ,IF(cart_cnt_30d IS NULL,0,cart_cnt_30d) AS cart_cnt_30d
        ,IF(ord_cnt_30d IS NULL,0,ord_cnt_30d) AS ord_cnt_30d
        ,IF(search_cnt_30d IS NULL,0,search_cnt_30d) AS search_cnt_30d
        ,IF(view_cnt_15d IS NULL,0,view_cnt_15d) AS view_cnt_15d
        ,IF(collect_cnt_15d IS NULL,0,collect_cnt_15d) AS collect_cnt_15d
        ,IF(cart_cnt_15d IS NULL,0,cart_cnt_15d) AS cart_cnt_15d
        ,IF(ord_cnt_15d IS NULL,0,ord_cnt_15d) AS ord_cnt_15d
        ,IF(search_cnt_15d IS NULL,0,search_cnt_15d) AS search_cnt_15d
        ,IF(view_cnt_7d IS NULL,0,view_cnt_7d) AS view_cnt_7d
        ,IF(collect_cnt_7d IS NULL,0,collect_cnt_7d) AS collect_cnt_7d
        ,IF(cart_cnt_7d IS NULL,0,cart_cnt_7d) AS cart_cnt_7d
        ,IF(ord_cnt_7d IS NULL,0,ord_cnt_7d) AS ord_cnt_7d
        ,IF(search_cnt_7d IS NULL,0,search_cnt_7d) AS search_cnt_7d
        ,is_expose
        ,label
FROM    dsc_sh_taobao_umeng_tfhwgg.ph_homo_group_alluser_${scheme_id}
WHERE   rn <= 1000000
;


DROP TABLE IF EXISTS ph_homo_group_${scheme_id}_test_set;
CREATE TABLE ph_homo_group_${scheme_id}_test_set LIFECYCLE 14 AS
SELECT  oneid
        ,age
        ,gender
        ,freq_city_tier
        ,freq_area
        ,profession
        ,education_degree
        ,consumption_level
        ,online_hours
        ,mobile_os
        ,mobile_price
        ,IF(is_active_30d IS NULL,0,is_active_30d) AS is_active_30d
        ,IF(is_active_15d IS NULL,0,is_active_15d) AS is_active_15d
        ,IF(is_active_7d IS NULL,0,is_active_7d) AS is_active_7d
        ,IF(view_cnt_30d IS NULL,0,view_cnt_30d) AS view_cnt_30d
        ,IF(collect_cnt_30d IS NULL,0,collect_cnt_30d) AS collect_cnt_30d
        ,IF(cart_cnt_30d IS NULL,0,cart_cnt_30d) AS cart_cnt_30d
        ,IF(ord_cnt_30d IS NULL,0,ord_cnt_30d) AS ord_cnt_30d
        ,IF(search_cnt_30d IS NULL,0,search_cnt_30d) AS search_cnt_30d
        ,IF(view_cnt_15d IS NULL,0,view_cnt_15d) AS view_cnt_15d
        ,IF(collect_cnt_15d IS NULL,0,collect_cnt_15d) AS collect_cnt_15d
        ,IF(cart_cnt_15d IS NULL,0,cart_cnt_15d) AS cart_cnt_15d
        ,IF(ord_cnt_15d IS NULL,0,ord_cnt_15d) AS ord_cnt_15d
        ,IF(search_cnt_15d IS NULL,0,search_cnt_15d) AS search_cnt_15d
        ,IF(view_cnt_7d IS NULL,0,view_cnt_7d) AS view_cnt_7d
        ,IF(collect_cnt_7d IS NULL,0,collect_cnt_7d) AS collect_cnt_7d
        ,IF(cart_cnt_7d IS NULL,0,cart_cnt_7d) AS cart_cnt_7d
        ,IF(ord_cnt_7d IS NULL,0,ord_cnt_7d) AS ord_cnt_7d
        ,IF(search_cnt_7d IS NULL,0,search_cnt_7d) AS search_cnt_7d
        ,is_expose
        ,label
FROM    dsc_sh_taobao_umeng_tfhwgg.ph_homo_group_expose_crowds_${scheme_id}
WHERE   rn > 2000000 AND rn <= 2500000
UNION ALL 
SELECT  oneid
        ,age
        ,gender
        ,freq_city_tier
        ,freq_area
        ,profession
        ,education_degree
        ,consumption_level
        ,online_hours
        ,mobile_os
        ,mobile_price
        ,IF(is_active_30d IS NULL,0,is_active_30d) AS is_active_30d
        ,IF(is_active_15d IS NULL,0,is_active_15d) AS is_active_15d
        ,IF(is_active_7d IS NULL,0,is_active_7d) AS is_active_7d
        ,IF(view_cnt_30d IS NULL,0,view_cnt_30d) AS view_cnt_30d
        ,IF(collect_cnt_30d IS NULL,0,collect_cnt_30d) AS collect_cnt_30d
        ,IF(cart_cnt_30d IS NULL,0,cart_cnt_30d) AS cart_cnt_30d
        ,IF(ord_cnt_30d IS NULL,0,ord_cnt_30d) AS ord_cnt_30d
        ,IF(search_cnt_30d IS NULL,0,search_cnt_30d) AS search_cnt_30d
        ,IF(view_cnt_15d IS NULL,0,view_cnt_15d) AS view_cnt_15d
        ,IF(collect_cnt_15d IS NULL,0,collect_cnt_15d) AS collect_cnt_15d
        ,IF(cart_cnt_15d IS NULL,0,cart_cnt_15d) AS cart_cnt_15d
        ,IF(ord_cnt_15d IS NULL,0,ord_cnt_15d) AS ord_cnt_15d
        ,IF(search_cnt_15d IS NULL,0,search_cnt_15d) AS search_cnt_15d
        ,IF(view_cnt_7d IS NULL,0,view_cnt_7d) AS view_cnt_7d
        ,IF(collect_cnt_7d IS NULL,0,collect_cnt_7d) AS collect_cnt_7d
        ,IF(cart_cnt_7d IS NULL,0,cart_cnt_7d) AS cart_cnt_7d
        ,IF(ord_cnt_7d IS NULL,0,ord_cnt_7d) AS ord_cnt_7d
        ,IF(search_cnt_7d IS NULL,0,search_cnt_7d) AS search_cnt_7d
        ,is_expose
        ,label
FROM    dsc_sh_taobao_umeng_tfhwgg.ph_homo_group_alluser_${scheme_id}
WHERE   rn > 1000000 AND rn <= 1500000
;


--------------------------- model ---------------------------
PAI -name gbdt
    -project algo_public
    -DfeatureSplitValueMaxSize="200"
    -DrandSeed="42"
    -Dshrinkage="0.05"
    -DmaxLeafCount="64"
    -DlabelColName="is_expose"
    -DinputTableName="ph_homo_group_${scheme_id}_training_set"
    -DminLeafSampleCount="50"
    -DsampleRatio="0.7"
    -DmaxDepth="8"
    -DmodelName="gbdt_rg_${scheme_id}"
    -DmetricType="2"
    -DfeatureRatio="0.7"
    -DfeatureColNames="profession,education_degree,consumption_level,online_hours,mobile_os,mobile_price,is_active_30d,is_active_15d,is_active_7d,view_cnt_30d,collect_cnt_30d,cart_cnt_30d,ord_cnt_30d,search_cnt_30d,view_cnt_15d,collect_cnt_15d,cart_cnt_15d,ord_cnt_15d,search_cnt_15d,view_cnt_7d,collect_cnt_7d,cart_cnt_7d,ord_cnt_7d,search_cnt_7d"
    -DtreeCount="200"
;


DROP TABLE IF EXISTS ph_homo_group_${scheme_id}_training_set_result;
DROP TABLE IF EXISTS ph_homo_group_${scheme_id}_test_set_result;
-- training set predict
PAI -name prediction
    -project algo_public
    -DinputTableName=ph_homo_group_${scheme_id}_training_set
    -DmodelName=gbdt_rg_${scheme_id}
    -DresultColName="pred_result"
    -DscoreColName="pred_score"
    -DoutputTableName=ph_homo_group_${scheme_id}_training_set_result
    -DappendColNames="is_expose,label"
    -Dlifecycle=14
;

-- test set predict
PAI -name prediction
    -project algo_public
    -DinputTableName=ph_homo_group_${scheme_id}_test_set
    -DmodelName=gbdt_rg_${scheme_id}
    -DresultColName="pred_result"
    -DscoreColName="pred_score"
    -DoutputTableName=ph_homo_group_${scheme_id}_test_set_result
    -DappendColNames="is_expose,label"
    -Dlifecycle=14
;






--------------------------- PropensityScoreCalculation ---------------------------
DROP TABLE IF EXISTS ph_homo_group_expose_crowds_output_${scheme_id};
PAI -name prediction
    -project algo_public
    -DinputTableName=ph_homo_group_expose_crowds_${scheme_id}
    -DmodelName=gbdt_rg_${scheme_id}
    -DresultColName="pred_result"
    -DscoreColName="pred_score"
    -DoutputTableName=ph_homo_group_expose_crowds_output_${scheme_id}
    -DappendColNames="oneid,age,gender,freq_city_tier,freq_area,profession,education_degree,consumption_level,mobile_os,mobile_price,is_active_30d,view_cnt_30d,search_cnt_30d,ord_cnt_30d"
    -Dlifecycle=14
;


DROP TABLE IF EXISTS ph_homo_group_alluser_output_${scheme_id};
PAI -name prediction
    -project algo_public
    -DinputTableName=ph_homo_group_alluser_${scheme_id}
    -DmodelName=gbdt_rg_${scheme_id}
    -DresultColName="pred_result"
    -DscoreColName="pred_score"
    -DoutputTableName=ph_homo_group_alluser_output_${scheme_id}
    -DappendColNames="oneid,age,gender,freq_city_tier,freq_area,profession,education_degree,consumption_level,mobile_os,mobile_price,is_active_30d,view_cnt_30d,search_cnt_30d,ord_cnt_30d"
    -Dlifecycle=14
;







--------------------------- HashGrouping ---------------------------
DROP TABLE IF EXISTS ph_homo_group_crowds_hash_group_output_${scheme_id};
CREATE TABLE IF NOT EXISTS ph_homo_group_crowds_hash_group_output_${scheme_id} LIFECYCLE 7 AS
WITH base AS (
    SELECT *, ROUND(pred_score,2) AS score_4, 'expose' AS label
    FROM dsc_sh_taobao_umeng_tfhwgg.ph_homo_group_expose_crowds_output_${scheme_id}
    UNION ALL 
    SELECT *, ROUND(pred_score,2) AS score_4, 'alluser' AS label
    FROM dsc_sh_taobao_umeng_tfhwgg.ph_homo_group_alluser_output_${scheme_id}
) 
,final AS (
    SELECT 
        *,
        -- Create hash-based group identifier
        HASH(CONCAT(age, '_', gender, '_', freq_city_tier, '_', freq_area, '_', education_degree, '_', consumption_level, '_', score_4)) AS feature_group
    FROM base
)
SELECT *, ROW_NUMBER() OVER(PARTITION BY feature_group, label ORDER BY RAND()) AS group_row_number
FROM final;


DROP TABLE IF EXISTS ph_homo_group_final_pair_${scheme_id};
CREATE TABLE IF NOT EXISTS ph_homo_group_final_pair_${scheme_id} LIFECYCLE 14 AS
SELECT  a.oneid, b.oneid AS paired_oneid, a.pred_score, b.pred_score AS paired_pred_score, a.feature_group
        ,a.profession
        ,a.mobile_os
        ,a.mobile_price
        ,a.is_active_30d
        ,a.view_cnt_30d
        ,a.search_cnt_30d
        ,a.ord_cnt_30d
        ,b.profession AS paired_profession
        ,b.mobile_os AS paired_mobile_os
        ,b.mobile_price AS paired_mobile_price
        ,b.is_active_30d AS paired_is_active_30d
        ,b.view_cnt_30d AS paired_view_cnt_30d
        ,b.search_cnt_30d AS paired_search_cnt_30d
        ,b.ord_cnt_30d AS paired_ord_cnt_30d
        ,'weekflow' AS label
FROM    (
    SELECT *
    FROM ph_homo_group_crowds_hash_group_output_${scheme_id}
    WHERE label = 'expose'
) a
LEFT JOIN (
    SELECT *
    FROM ph_homo_group_crowds_hash_group_output_${scheme_id}
    WHERE label = 'alluser'
) b
ON      a.feature_group = b.feature_group
AND     a.group_row_number = b.group_row_number;






--------------------------- Homo_Result_Download ---------------------------
SET odps.instance.priority = 1;

CREATE TABLE IF NOT EXISTS ph_homo_group_paired_crowds_storage
(
    oneid STRING COMMENT '曝光oneid',
    paired_oneid STRING COMMENT '同质oneid'
)
COMMENT '同质人群匹配结果存储表'
PARTITIONED BY (
    scheme_id STRING COMMENT '方案id'
)
LIFECYCLE 365
;

INSERT OVERWRITE TABLE ph_homo_group_paired_crowds_storage PARTITION (scheme_id = '${scheme_id}')
SELECT oneid, paired_oneid
FROM ph_homo_group_final_pair_${scheme_id}
WHERE paired_oneid IS NOT NULL
;






--------------------------- Test UDF ---------------------------
#coding:utf-8
from odps.udf import annotate
from odps.distcache import get_cache_archive

def include_package_path(res_name):
    import os, sys
    archive_files = get_cache_archive(res_name)
    dir_names = sorted([os.path.dirname(os.path.normpath(f.name)) for f in archive_files
                    if '.dist_info' not in f.name], key=lambda v: len(v))
    sys.path.append(os.path.dirname(dir_names[0]))


@annotate('array,array->double')
class psm_ttest(object):
    def __init__(self):        
        include_package_path('scipy-1.7.3-cp37-cp37m-manylinux_2_12_x86_64.manylinux2010_x86_64.zip')
        include_package_path('numpy-1.14.5-cp37-cp37m-manylinux1_x86_64.zip')

    
    def evaluate(self, exp_group, control_group):
        try:
            import scipy.stats as stats
            t_stat, p_value = stats.ttest_ind(exp_group, control_group)
            return float(p_value)
        except:
            return None