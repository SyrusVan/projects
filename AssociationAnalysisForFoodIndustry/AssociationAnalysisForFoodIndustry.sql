------------------------------ Association Rules ------------------------------
DROP TABLE IF EXISTS association_analysis_mid_tbl_7d;
CREATE TABLE IF NOT EXISTS association_analysis_mid_tbl_7d LIFECYCLE 7 AS
WITH user_label AS (
    SELECT  user_id, ulabel
    FROM    (
        SELECT  *
        FROM    crowd_center_dev.vt_dwd_crowd_center_upro_lingyang_kx_dynamic_crowd_detail_df
        WHERE   ds = MAX_PT('crowd_center.dwd_crowd_center_upro_lingyang_kx_dynamic_crowd_detail_df')
    ) a
    LATERAL VIEW EXPLODE(SPLIT(kx_crowd_w_auge,',')) t AS ulabel
    GROUP BY user_id, ulabel
)
,user_cats AS (
    SELECT  oneid, cate_name, cate_level2_name, cate_level1_name, c.ulabel
    FROM    (
        SELECT CONCAT_WS('-',oneid,'1') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260205','20260211') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'2') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260215','20260221') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'3') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260225','20260303') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'4') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260305','20260311') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'5') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260315','20260321') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'6') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260325','20260331') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'7') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260105','20260111') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'8') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260115','20260121') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'9') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20260125','20260131') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'10') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20251205','20251211') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'11') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20251215','20251221') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'12') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20251225','20251231') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'13') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250905','20250911') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'14') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250915','20250921') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'15') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250925','20251001') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'16') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250805','20250811') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'17') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250815','20250821') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'18') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250825','20250831') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'19') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250705','20250711') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'20') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250715','20250721') WHERE pay_gmv > 0
        UNION ALL
        SELECT CONCAT_WS('-',oneid,'21') AS oneid, cate_id FROM crowd_center_dev.vt_dws_user_trace_di ('20250725','20250731') WHERE pay_gmv > 0
    ) a
    JOIN    (
        SELECT  cate_id, cate_name, cate_level2_name, cate_level1_name
        FROM    crowd_center_dev.vt_dim_tm_cate_industry
        WHERE   ind1_name = '食品生鲜'
        AND     cate_name IN ('粽叶','木瓜','特色/复合食品添加剂','养生配制酒','食盐','肠衣/肠类加工原料','挂耳咖啡','包点','口香糖','酱类调料','黑木耳','奶茶饮料','大蒜','香蕉干/片','棒棒糖','其他','烧烤调料/腌料','即饮咖啡','银耳/冻干银耳及银耳制品','复合食品调味剂','蔬果干/香菇干/混合果干','果仁巧克力','纯燕麦片','奶皮','鸭肉/鸭肉制品','杯装奶茶','葡萄干','金骏眉','脱水蔬菜','特色米/面粉/杂粮','鸡精/味精/鸡粉','饮用天然矿泉水/饮用天然水','吐司面包','淡水鱼类','豆奶粉','香油','活珠子/毛胚蛋','其它原料','月饼','桑椹干','其他食品','豆浆','小龙虾调料','白酒/调香白酒','土豆','料酒','曲奇饼干','蔓越莓干','山楂类制品','沙琪玛','营养（消化）饼干','鲜花饼','香肠/腊肠/烤肠','特色产区绿茶','欧式面包','功能糖果/压片糖果','甜瓜','冻干速溶水果块茶/果粒茶','水牛奶','坚果礼盒','东北松子','膨化食品','天然粉粉食品','芝士/奶酪蛋糕','果冻/布丁粉','多谷物麦片','白砂糖包','复合调味汁/冷泡汁/糟卤类','碧螺春','鸡肉丸/肉串','咖啡豆','榴莲','水果/坚果混合麦片','醋/醋制品/果醋','海带','植物饮料','牛丸/肉串','茉莉花茶','发酵饼干','金桔类制品','陈皮','馅饼/烧饼/锅盔','传统黄酒','鸡胸','烘焙馅料','预拌粉','冻干水果/冻干奶块/混合冻干','浓缩果蔬汁','中式养生冲饮','水饺/煎饺/虾饺','调味茶饮料','黑巧克力','自热火锅','再制奶酪','即食虾零食','糯米','纯牛奶','功能饮料/运动蛋白饮料','火腿/即食火腿/加工火腿','果酱/鲜花酱/甜味酱','凤梨','面筋制品','再加工茶/配方茶/调味茶','杏仁/巴旦木','威化饼干','驼奶及驼奶粉','面粉/食用粉','黑米','特色饮品','豆类制品','番茄酱','百合干','巧克力制品','即食鱼零食','火锅调料','荔枝','其它','中式糕点/新中式糕点','玫瑰花茶','冲饮果汁','薄荷糖','咖啡液','大红袍','馄饨/抄手/云吞/肉燕','麻薯/大福/青团','猪肉类','包装即食肠类','豆腐皮/腐竹/豆制品干货','羊肚菌','茶叶蛋/卤蛋','凉茶','芒果','夹心面包','酸奶粉','酸枣糕/酸角/沙棘/刺梨','酵母粉','苹果干','薯类制品','珍珠奶茶粉','酥糖','虾仁','芋头','可可/巧克力饮品','预调鸡尾酒/Alcopop','意大利面','蔬菜干','豆腐乳','芝麻','袋装奶茶','梅类制品','学生奶粉','玉米','小苏打','腌肉/腊肉/腊禽类','方便粉丝/粉条','干货粉条粉丝/蕨根粉/苕皮','橙','绿豆糕','冲饮酸梅汤','手抓饼/葱油饼/煎饼/卷饼','汤圆/元宵','粽子','即食板栗','混合坚果','臭豆腐','酸奶','洋葱/红葱头','芝士新','其他烘焙半成品','鸡蛋','水果罐头','腰果','纯茶饮料','方便米线/米粉','素肉','瓜子','长寿果/碧根果','芋圆','杏仁/杏干','喜饼/诞生礼饼','虾皮','大米','小米','番薯','特色干货及养生干料','自热米饭','米糕/桂花糕/发糕','白兰地/Brandy','南瓜','辣椒粉料/蘸料','地域特色/特产类调味品','冰淇淋/冻品','鸡肉/鸡肉制品','香蕉','特色产区红茶','黄油','酱油','啤酒','无花果干','开心果','待煮速食面/拉面/面皮/西式面','喜糖','代用/花草茶','苏打饼干','夹心巧克力','其他食品提货券','鱼类罐头','米酒','组合型花茶','纸皮/薄皮核桃','龙井茶（非西湖）','柚子','轻食简餐','叶菜类','肉制品/肉类罐头','番茄','橄榄油','牛奶巧克力','杂粮组合/膳食混合谷物','其它生肉制品','原制奶酪','传统西式糕点','葵花籽油','全家营养奶粉','蚝油','豆腐干','辣椒酱','威士忌/Whiskey','香菇类','红糖/黑糖/风味红糖','杏','橄榄','普洱','果冻/布丁','桃','蛋黄酥','花生','果酒','玉米糁/玉米渣','番石榴/芭乐','夹心饼干','人参果','中老年奶粉','辣椒','芒果干','椰子油','苹果','烧麦/烧卖','薏米','生猪肉','糖浆','奶片','鳕鱼','车厘子/樱桃','食用色素/天然果蔬着色粉','黑豆','新鲜豆类','虾干','干货组合/料包/汤包/干货礼盒','鸭肉零食','桂圆干/龙眼','绿豆','哈密瓜','新鲜山药','百香果','新鲜玉米','蓝莓','干红静态葡萄酒','调制乳（风味奶）','牛排','低温酸奶','速食汤','气泡水','桃酥/核桃酥','香辛料/干调类','棉花糖/牛轧糖/充气糖果','调和油','沙拉/千岛/蛋黄酱/油醋汁','饮用纯净水','饭团/八宝饭','松花/皮蛋','包装速食菜/预制菜','生牛肉','糙米','即食鱿鱼零食','奶精炼乳','鱼干','咖喱/粉/块/酱','豆瓣酱/豆酱/黄豆酱','莲子','冻虾','李子','速食粥','汤类调料/冬阴功汤料/汤包','纯果蔬汁/纯果汁','电解质饮料','凤凰单丛','海带零食','学生/成人/中老年羊奶粉','柠檬','烧鸡/扒鸡/鸡熟食','椰子片','花椒油/藤椒油','虾类制品','红豆','西式快餐','咸鸭蛋','铁观音','奶油','猪蹄/猪肘/猪肉类熟食','鱼丸/鱼滑','大豆油','预制披萨/面团','果汁茶饮料','寿司料理/料理调料','蛋卷','桔子','下饭/拌饭酱/拌饭料','牛油果','鸡肉零食','面条/挂面（无料包）','燕麦','核桃仁','贝类制品','正山小种','薄脆饼干','麻花','黄瓜','研磨咖啡粉','紫菜/海苔','枣类制品','菊花茶','蟹系列','奇异果/猕猴桃','枇杷','梨','植物蛋白饮料/植物奶/植物酸奶','果味/风味/果汁饮料','菜籽油','酱菜/下饭菜/外婆菜','传统糖果','火龙果','藕粉','抹茶粉','面包糠','生姜/南姜','碳酸饮料','蛋挞原料','花生油','酥性饼干','黄糖/冰糖','苏打水','油条/春卷','含乳饮料','柿饼/柿子制品','软糖/果味糖/凝胶糖果','亚麻籽油','速溶咖啡','胶囊咖啡','芝麻饼/芝麻片','滇红','年糕/糍粑','甜型葡萄酒（含贵腐/冰酒）','低温奶','韧性饼干','海参','螺蛳粉','萝卜/胡萝卜','糕点礼盒/伴手礼','卤味素食','白糖/食糖','手撕面包','泡打粉','夏威夷果','海苔系列','三文鱼','黄豆','藜麦','鸡翅/鸡翅制品','腌制/榨菜/泡菜','笋类制品','压缩饼干','特色油种','牛肉类','咖啡','冲泡方便面/拉面/面皮','冷面/烤冷面','营养复合麦片','芝麻糊','葱类','玉米油','槟榔')
        GROUP BY cate_id, cate_name, cate_level2_name, cate_level1_name
    ) b
    ON      a.cate_id = b.cate_id
    JOIN    user_label c
    ON      SPLIT(a.oneid,'-')[0] = c.user_id
    GROUP BY oneid, cate_name, cate_level2_name, cate_level1_name, c.ulabel
)
,cat_single_stats AS (
    SELECT 
        cate_name, cate_level2_name, cate_level1_name, ulabel,
        COUNT(*) AS cat_count  
    FROM 
        user_cats
    GROUP BY 
        cate_name, cate_level2_name, cate_level1_name, ulabel
)
,pair_stats AS (
    SELECT 
        t1.cate_name AS cat_a,
        t2.cate_name AS cat_b,
        t1.cate_level2_name AS cat_2_a,
        t2.cate_level2_name AS cat_2_b,
        t1.cate_level1_name AS cat_1_a,
        t2.cate_level1_name AS cat_1_b,
        t1.ulabel,
        COUNT(DISTINCT t1.oneid) AS pair_count  
    FROM 
        user_cats t1
    JOIN 
        user_cats t2
    ON 
        t1.oneid = t2.oneid
        AND t1.cate_name < t2.cate_name  
        AND t1.ulabel = t2.ulabel
    GROUP BY 
        t1.cate_name,
        t2.cate_name,
        t1.cate_level2_name,
        t2.cate_level2_name,
        t1.cate_level1_name,
        t2.cate_level1_name,
        t1.ulabel
)
SELECT *
FROM   (
    SELECT
        p.ulabel,
        p.cat_a,
        p.cat_b,
        p.cat_2_a,
        p.cat_2_b,
        p.cat_1_a,
        p.cat_1_b,
        p.pair_count,
        s_a.cat_count AS count_a,
        s_b.cat_count AS count_b,
        ROUND(p.pair_count * 1.0 / s_a.cat_count, 4) AS confidence_a_to_b,
        ROUND(p.pair_count * 1.0 / s_b.cat_count, 4) AS confidence_b_to_a,
        ROUND((p.pair_count * 1.0 / s_a.cat_count) / (s_b.cat_count * 1.0 / (SELECT COUNT(DISTINCT oneid) FROM user_cats)), 4) AS lift_a_to_b
    FROM 
        pair_stats p
    JOIN 
        cat_single_stats s_a ON p.cat_a = s_a.cate_name AND p.cat_2_a = s_a.cate_level2_name AND p.ulabel = s_a.ulabel AND p.cat_1_a = s_a.cate_level1_name
    JOIN 
        cat_single_stats s_b ON p.cat_b = s_b.cate_name AND p.cat_2_b = s_b.cate_level2_name AND p.ulabel = s_b.ulabel AND p.cat_1_b = s_b.cate_level1_name
    WHERE 
        p.cat_a NOT LIKE '%其他%'
        AND p.cat_a NOT LIKE '%提货券%'
        AND p.cat_b NOT LIKE '%其他%'
        AND p.cat_b NOT LIKE '%提货券%'
) aa;



------------------------------ Effect Predict (Brands) ------------------------------
DROP TABLE IF EXISTS association_analysis_effect_predict_brand_comb;
CREATE TABLE IF NOT EXISTS association_analysis_effect_predict_brand_comb LIFECYCLE 30 AS
WITH user_label AS (
    SELECT  user_id, ulabel
    FROM    (
        SELECT  *
        FROM    crowd_center_dev.vt_dwd_crowd_center_upro_lingyang_kx_dynamic_crowd_detail_df
        WHERE   ds = MAX_PT('crowd_center.dwd_crowd_center_upro_lingyang_kx_dynamic_crowd_detail_df')
    ) a
    LATERAL VIEW EXPLODE(SPLIT(kx_crowd_w_auge,',')) t AS ulabel
    GROUP BY user_id, ulabel
)
,cate AS (
    SELECT  cate_id, cate_name, cate_level2_name, cate_level1_name
    FROM    crowd_center_dev.vt_dim_tm_cate_industry
    WHERE   ind1_name = '食品生鲜'
    AND     cate_name IN ('粽叶','木瓜','特色/复合食品添加剂','养生配制酒','食盐','肠衣/肠类加工原料','挂耳咖啡','包点','口香糖','酱类调料','黑木耳','奶茶饮料','大蒜','香蕉干/片','棒棒糖','其他','烧烤调料/腌料','即饮咖啡','银耳/冻干银耳及银耳制品','复合食品调味剂','蔬果干/香菇干/混合果干','果仁巧克力','纯燕麦片','奶皮','鸭肉/鸭肉制品','杯装奶茶','葡萄干','金骏眉','脱水蔬菜','特色米/面粉/杂粮','鸡精/味精/鸡粉','饮用天然矿泉水/饮用天然水','吐司面包','淡水鱼类','豆奶粉','香油','活珠子/毛胚蛋','其它原料','月饼','桑椹干','其他食品','豆浆','小龙虾调料','白酒/调香白酒','土豆','料酒','曲奇饼干','蔓越莓干','山楂类制品','沙琪玛','营养（消化）饼干','鲜花饼','香肠/腊肠/烤肠','特色产区绿茶','欧式面包','功能糖果/压片糖果','甜瓜','冻干速溶水果块茶/果粒茶','水牛奶','坚果礼盒','东北松子','膨化食品','天然粉粉食品','芝士/奶酪蛋糕','果冻/布丁粉','多谷物麦片','白砂糖包','复合调味汁/冷泡汁/糟卤类','碧螺春','鸡肉丸/肉串','咖啡豆','榴莲','水果/坚果混合麦片','醋/醋制品/果醋','海带','植物饮料','牛丸/肉串','茉莉花茶','发酵饼干','金桔类制品','陈皮','馅饼/烧饼/锅盔','传统黄酒','鸡胸','烘焙馅料','预拌粉','冻干水果/冻干奶块/混合冻干','浓缩果蔬汁','中式养生冲饮','水饺/煎饺/虾饺','调味茶饮料','黑巧克力','自热火锅','再制奶酪','即食虾零食','糯米','纯牛奶','功能饮料/运动蛋白饮料','火腿/即食火腿/加工火腿','果酱/鲜花酱/甜味酱','凤梨','面筋制品','再加工茶/配方茶/调味茶','杏仁/巴旦木','威化饼干','驼奶及驼奶粉','面粉/食用粉','黑米','特色饮品','豆类制品','番茄酱','百合干','巧克力制品','即食鱼零食','火锅调料','荔枝','其它','中式糕点/新中式糕点','玫瑰花茶','冲饮果汁','薄荷糖','咖啡液','大红袍','馄饨/抄手/云吞/肉燕','麻薯/大福/青团','猪肉类','包装即食肠类','豆腐皮/腐竹/豆制品干货','羊肚菌','茶叶蛋/卤蛋','凉茶','芒果','夹心面包','酸奶粉','酸枣糕/酸角/沙棘/刺梨','酵母粉','苹果干','薯类制品','珍珠奶茶粉','酥糖','虾仁','芋头','可可/巧克力饮品','预调鸡尾酒/Alcopop','意大利面','蔬菜干','豆腐乳','芝麻','袋装奶茶','梅类制品','学生奶粉','玉米','小苏打','腌肉/腊肉/腊禽类','方便粉丝/粉条','干货粉条粉丝/蕨根粉/苕皮','橙','绿豆糕','冲饮酸梅汤','手抓饼/葱油饼/煎饼/卷饼','汤圆/元宵','粽子','即食板栗','混合坚果','臭豆腐','酸奶','洋葱/红葱头','芝士新','其他烘焙半成品','鸡蛋','水果罐头','腰果','纯茶饮料','方便米线/米粉','素肉','瓜子','长寿果/碧根果','芋圆','杏仁/杏干','喜饼/诞生礼饼','虾皮','大米','小米','番薯','特色干货及养生干料','自热米饭','米糕/桂花糕/发糕','白兰地/Brandy','南瓜','辣椒粉料/蘸料','地域特色/特产类调味品','冰淇淋/冻品','鸡肉/鸡肉制品','香蕉','特色产区红茶','黄油','酱油','啤酒','无花果干','开心果','待煮速食面/拉面/面皮/西式面','喜糖','代用/花草茶','苏打饼干','夹心巧克力','其他食品提货券','鱼类罐头','米酒','组合型花茶','纸皮/薄皮核桃','龙井茶（非西湖）','柚子','轻食简餐','叶菜类','肉制品/肉类罐头','番茄','橄榄油','牛奶巧克力','杂粮组合/膳食混合谷物','其它生肉制品','原制奶酪','传统西式糕点','葵花籽油','全家营养奶粉','蚝油','豆腐干','辣椒酱','威士忌/Whiskey','香菇类','红糖/黑糖/风味红糖','杏','橄榄','普洱','果冻/布丁','桃','蛋黄酥','花生','果酒','玉米糁/玉米渣','番石榴/芭乐','夹心饼干','人参果','中老年奶粉','辣椒','芒果干','椰子油','苹果','烧麦/烧卖','薏米','生猪肉','糖浆','奶片','鳕鱼','车厘子/樱桃','食用色素/天然果蔬着色粉','黑豆','新鲜豆类','虾干','干货组合/料包/汤包/干货礼盒','鸭肉零食','桂圆干/龙眼','绿豆','哈密瓜','新鲜山药','百香果','新鲜玉米','蓝莓','干红静态葡萄酒','调制乳（风味奶）','牛排','低温酸奶','速食汤','气泡水','桃酥/核桃酥','香辛料/干调类','棉花糖/牛轧糖/充气糖果','调和油','沙拉/千岛/蛋黄酱/油醋汁','饮用纯净水','饭团/八宝饭','松花/皮蛋','包装速食菜/预制菜','生牛肉','糙米','即食鱿鱼零食','奶精炼乳','鱼干','咖喱/粉/块/酱','豆瓣酱/豆酱/黄豆酱','莲子','冻虾','李子','速食粥','汤类调料/冬阴功汤料/汤包','纯果蔬汁/纯果汁','电解质饮料','凤凰单丛','海带零食','学生/成人/中老年羊奶粉','柠檬','烧鸡/扒鸡/鸡熟食','椰子片','花椒油/藤椒油','虾类制品','红豆','西式快餐','咸鸭蛋','铁观音','奶油','猪蹄/猪肘/猪肉类熟食','鱼丸/鱼滑','大豆油','预制披萨/面团','果汁茶饮料','寿司料理/料理调料','蛋卷','桔子','下饭/拌饭酱/拌饭料','牛油果','鸡肉零食','面条/挂面（无料包）','燕麦','核桃仁','贝类制品','正山小种','薄脆饼干','麻花','黄瓜','研磨咖啡粉','紫菜/海苔','枣类制品','菊花茶','蟹系列','奇异果/猕猴桃','枇杷','梨','植物蛋白饮料/植物奶/植物酸奶','果味/风味/果汁饮料','菜籽油','酱菜/下饭菜/外婆菜','传统糖果','火龙果','藕粉','抹茶粉','面包糠','生姜/南姜','碳酸饮料','蛋挞原料','花生油','酥性饼干','黄糖/冰糖','苏打水','油条/春卷','含乳饮料','柿饼/柿子制品','软糖/果味糖/凝胶糖果','亚麻籽油','速溶咖啡','胶囊咖啡','芝麻饼/芝麻片','滇红','年糕/糍粑','甜型葡萄酒（含贵腐/冰酒）','低温奶','韧性饼干','海参','螺蛳粉','萝卜/胡萝卜','糕点礼盒/伴手礼','卤味素食','白糖/食糖','手撕面包','泡打粉','夏威夷果','海苔系列','三文鱼','黄豆','藜麦','鸡翅/鸡翅制品','腌制/榨菜/泡菜','笋类制品','压缩饼干','特色油种','牛肉类','咖啡','冲泡方便面/拉面/面皮','冷面/烤冷面','营养复合麦片','芝麻糊','葱类','玉米油','槟榔')
    GROUP BY cate_id, cate_name, cate_level2_name, cate_level1_name
)
,association AS (
    SELECT ulabel, cat_a, cat_b
    FROM association_analysis_mid_tbl_lift
    WHERE cat_a LIKE '%油%'
      AND pair_count > 1000 AND lift_a_to_b > 1
      AND confidence_a_to_b > 0.02 AND confidence_b_to_a > 0.02
    GROUP BY ulabel, cat_a, cat_b
    UNION ALL
    SELECT ulabel, cat_a, cat_b
    FROM association_analysis_mid_tbl_lift
    WHERE cat_a LIKE '%膨化%'
      AND pair_count > 1000 AND lift_a_to_b > 1
      AND confidence_a_to_b > 0.02 AND confidence_b_to_a > 0.02
    GROUP BY ulabel, cat_a, cat_b
    UNION ALL
    SELECT ulabel, cat_a, cat_b
    FROM association_analysis_mid_tbl_lift
    WHERE cat_a LIKE '%咖啡%'
      AND pair_count > 1000 AND lift_a_to_b > 1
      AND confidence_a_to_b > 0.02 AND confidence_b_to_a > 0.02
    GROUP BY ulabel, cat_a, cat_b
    UNION ALL
    SELECT ulabel, cat_a, cat_b
    FROM association_analysis_mid_tbl_lift
    WHERE cat_a LIKE '%卤味%'
      AND pair_count > 1000 AND lift_a_to_b > 1
      AND confidence_a_to_b > 0.02 AND confidence_b_to_a > 0.02
    GROUP BY ulabel, cat_a, cat_b
    UNION ALL
    SELECT ulabel, cat_a, cat_b
    FROM association_analysis_mid_tbl_lift
    WHERE cat_a LIKE '%酒%'
      AND pair_count > 1000 AND lift_a_to_b > 1
      AND confidence_a_to_b > 0.02 AND confidence_b_to_a > 0.02
    GROUP BY ulabel, cat_a, cat_b
)
-- 历史周期：20260101-20260615 的类目购买
,hist_pay AS (
    SELECT user_id, cate_name
    FROM (
        SELECT DISTINCT
            oneid AS user_id,
            cate_id
        FROM crowd_center_dev.vt_dws_user_trace_di('20260101','20260615')
        WHERE pay_gmv > 0
    ) a
    JOIN cate b
    ON a.cate_id = b.cate_id
)
-- 自然转化周期：20260701-20260707 的类目购买
,conv_pay AS (
    SELECT user_id, cate_name
    FROM (
        SELECT DISTINCT
            oneid AS user_id,
            cate_id
        FROM crowd_center_dev.vt_dws_user_trace_di('20260701','20260707')
        WHERE pay_gmv > 0 -- 浏搜加人群
    ) a
    JOIN cate b
    ON a.cate_id = b.cate_id
)
-- 新客判定周期：20260301-20260701 的类目购买（用于识别非新客）
,new_period_pay AS (
    SELECT user_id, cate_name
    FROM (
        SELECT DISTINCT
            oneid AS user_id,
            cate_id
        FROM crowd_center_dev.vt_dws_user_trace_di('20260301','20260701')
        WHERE pay_gmv > 0
    ) a
    JOIN cate b
    ON a.cate_id = b.cate_id
)
-- A 类目历史行为人群（历史周期购买过 cat_a）
,a_behavior AS (
    SELECT
        a.ulabel,
        a.cat_a,
        --a.cat_b,
        hp.user_id
    FROM association a
    JOIN hist_pay hp ON hp.cate_name = a.cat_a
    JOIN user_label ul ON ul.ulabel = a.ulabel AND ul.user_id = hp.user_id
    GROUP BY a.ulabel, a.cat_a--, a.cat_b
    , hp.user_id
)
-- B 类目历史购买人群（历史周期购买过 cat_b）
,b_purchase AS (
    SELECT
        a.ulabel,
        a.cat_a,
        --a.cat_b,
        hp.user_id
    FROM association a
    JOIN hist_pay hp ON hp.cate_name = a.cat_b
    JOIN user_label ul ON ul.ulabel = a.ulabel AND ul.user_id = hp.user_id
    GROUP BY a.ulabel, a.cat_a--, a.cat_b
    , hp.user_id
)
-- 三类对比人群
,group_users AS (
    -- 人群 1：A 类目历史行为人群 ∪ B 类目历史购买人群
    SELECT ulabel, cat_a, user_id, 'A_union_B' AS group_type
    FROM (
        SELECT ulabel, cat_a, user_id FROM a_behavior
        UNION
        SELECT ulabel, cat_a, user_id FROM b_purchase
    ) t

    UNION ALL

    -- 人群 2：A 类目历史行为人群
    SELECT ulabel, cat_a, user_id, 'A_only' AS group_type
    FROM a_behavior

    UNION ALL

    -- 人群 3：A 类目历史行为人群 ∩ B 类目历史购买人群
    SELECT ulabel, cat_a, user_id, 'A_intersect_B' AS group_type
    FROM (
        SELECT ulabel, cat_a, user_id FROM a_behavior
        INTERSECT
        SELECT ulabel, cat_a, user_id FROM b_purchase
    ) t
)
-- 标记每个人群用户在转化周期是否购买 A 类目，以及是否为新客
,converted AS (
    SELECT
        gu.ulabel,
        gu.cat_a,
        --gu.cat_b,
        gu.group_type,
        gu.user_id,
        CASE WHEN cp.user_id IS NOT NULL THEN 1 ELSE 0 END AS is_converted,
        CASE WHEN cp.user_id IS NOT NULL AND npp.user_id IS NULL THEN 1 ELSE 0 END AS is_new_converted
    FROM group_users gu
    LEFT JOIN conv_pay cp
        ON gu.user_id = cp.user_id
        AND cp.cate_name = gu.cat_a
    LEFT JOIN new_period_pay npp
        ON gu.user_id = npp.user_id
        AND npp.cate_name = gu.cat_a
)
-- 汇总：自然转化率 + 转化用户中新客占比
SELECT
    ulabel,
    cat_a,
    --cat_b,
    group_type,
    COUNT(DISTINCT user_id) AS group_user_cnt,
    SUM(is_converted) AS converted_cnt,
    ROUND(
        CAST(SUM(is_converted) AS DOUBLE) / CAST(COUNT(DISTINCT user_id) AS DOUBLE),
        6
    ) AS conversion_rate,
    SUM(is_new_converted) AS new_converted_cnt,
    ROUND(
        CAST(SUM(is_new_converted) AS DOUBLE)
        / NULLIF(CAST(SUM(is_converted) AS DOUBLE), 0),
        6
    ) AS new_customer_ratio
FROM converted
GROUP BY ulabel, cat_a, group_type
ORDER BY ulabel, cat_a, group_type
LIMIT 10000;



------------------------------ Effect Predict (Shop) ------------------------------
SET odps.instance.priority=1;
DROP TABLE IF EXISTS association_analysis_effect_predict_shop_comb;
CREATE TABLE IF NOT EXISTS association_analysis_effect_predict_shop_comb LIFECYCLE 30 AS
WITH user_label AS (
    SELECT  user_id, ulabel
    FROM    (
        SELECT  *
        FROM    crowd_center_dev.vt_dwd_crowd_center_upro_lingyang_kx_dynamic_crowd_detail_df
        WHERE   ds = MAX_PT('crowd_center.dwd_crowd_center_upro_lingyang_kx_dynamic_crowd_detail_df')
    ) a
    LATERAL VIEW EXPLODE(SPLIT(kx_crowd_w_auge,',')) t AS ulabel
    GROUP BY user_id, ulabel
)
,cate AS (
    SELECT  cate_id, cate_name, cate_level2_name, cate_level1_name
    FROM    crowd_center_dev.vt_dim_tm_cate_industry
    WHERE   ind1_name = '食品生鲜'
    GROUP BY cate_id, cate_name, cate_level2_name, cate_level1_name
)
,association AS (
    SELECT cat_a, cat_b
    FROM association_analysis_mid_tbl_lift
    WHERE pair_count > 1000 AND lift_a_to_b > 1
      AND confidence_a_to_b > 0.02 AND confidence_b_to_a > 0.02
    GROUP BY cat_a, cat_b
)
-- 目标店铺白名单
,seller_list AS (
    SELECT seller_id FROM (
        SELECT '1662156920' AS seller_id
        UNION ALL SELECT '2690281816'
        UNION ALL SELECT '2206419108171'
        UNION ALL SELECT '2214744547842'
        UNION ALL SELECT '822450862'
        UNION ALL SELECT '2211158536397'
        UNION ALL SELECT '1751752896'
        UNION ALL SELECT '202224264'
        UNION ALL SELECT '2201296918352'
        UNION ALL SELECT '745949152'
        UNION ALL SELECT '3965355244'
        UNION ALL SELECT '2214216898010'
        UNION ALL SELECT '2175881970'
        UNION ALL SELECT '2969746355'
        UNION ALL SELECT '2208626058094'
        UNION ALL SELECT '3716031670'
        UNION ALL SELECT '1985745737'
        UNION ALL SELECT '735261224'
        UNION ALL SELECT '2204157154975'
        UNION ALL SELECT '880734502'
        UNION ALL SELECT '3547718296'
        UNION ALL SELECT '2508879272'
    ) t
)
-- 历史周期：只看 cate，不用 seller
,hist_pay AS (
    SELECT user_id, cate_name
    FROM (
        SELECT DISTINCT
            oneid AS user_id,
            cate_id
        FROM crowd_center_dev.vt_dws_user_trace_di('20260101','20260615')
        WHERE pay_gmv > 0
    ) a
    JOIN cate b
    ON a.cate_id = b.cate_id
)
-- 自然转化周期：保留 seller_id，限定目标店铺
,conv_pay AS (
    SELECT user_id, cate_name, seller_id
    FROM (
        SELECT DISTINCT
            oneid AS user_id,
            cate_id,
            seller_id
        FROM crowd_center_dev.vt_dws_user_trace_di('20260701','20260707')
        WHERE pay_gmv > 0
          AND seller_id IN (SELECT seller_id FROM seller_list)
    ) a
    JOIN cate b
    ON a.cate_id = b.cate_id
)
-- 新客判定周期：只看 cate，不看 seller
,new_period_pay AS (
    SELECT user_id, cate_name
    FROM (
        SELECT DISTINCT
            oneid AS user_id,
            cate_id
        FROM crowd_center_dev.vt_dws_user_trace_di('20260301','20260701')
        WHERE pay_gmv > 0
    ) a
    JOIN cate b
    ON a.cate_id = b.cate_id
)
-- 店铺-类目映射：用于把类目人群展开到具体店铺（仅做映射，不参与行为定义）
,seller_cate_map AS (
    SELECT DISTINCT seller_id, cate_name AS cat_a
    FROM (
        SELECT DISTINCT
            oneid AS user_id,
            cate_id,
            seller_id
        FROM crowd_center_dev.vt_dws_user_trace_di('20260101','20260707')
        WHERE pay_gmv > 0
          AND seller_id IN (SELECT seller_id FROM seller_list)
    ) a
    JOIN cate b
    ON a.cate_id = b.cate_id
)
-- A 类目历史行为人群（历史周期购买过 cat_a，只看 cate）
,a_behavior AS (
    SELECT
        --a.ulabel,
        a.cat_a,
        hp.user_id
    FROM association a
    JOIN hist_pay hp ON hp.cate_name = a.cat_a
    JOIN user_label ul ON ul.user_id = hp.user_id
    GROUP BY a.cat_a, hp.user_id
)
-- B 类目历史购买人群（历史周期购买过 cat_b，只看 cate）
,b_purchase AS (
    SELECT
        --a.ulabel,
        a.cat_a,
        hp.user_id
    FROM association a
    JOIN hist_pay hp ON hp.cate_name = a.cat_b
    JOIN user_label ul ON ul.user_id = hp.user_id
    GROUP BY a.cat_a, hp.user_id
)
-- 三类对比人群，仅基于类目
,group_users AS (
    -- 人群 1：A 类目历史行为人群 ∪ B 类目历史购买人群
    SELECT cat_a, user_id, 'A_union_B' AS group_type
    FROM (
        SELECT cat_a, user_id FROM a_behavior
        UNION
        SELECT cat_a, user_id FROM b_purchase
    ) t

    UNION ALL

    -- 人群 2：A 类目历史行为人群
    SELECT cat_a, user_id, 'A_only' AS group_type
    FROM a_behavior

    UNION ALL

    -- 人群 3：A 类目历史行为人群 ∩ B 类目历史购买人群
    SELECT cat_a, user_id, 'A_intersect_B' AS group_type
    FROM (
        SELECT cat_a, user_id FROM a_behavior
        INTERSECT
        SELECT cat_a, user_id FROM b_purchase
    ) t
)
-- 把类目人群展开到店铺：只保留该店铺实际经营的 cat_a
,group_users_seller AS (
    SELECT
        --gu.ulabel,
        gu.cat_a,
        gu.group_type,
        gu.user_id,
        scm.seller_id
    FROM group_users gu
    JOIN seller_cate_map scm
        ON scm.cat_a = gu.cat_a
)
-- 标记每个人群用户是否在转化周期到对应 seller 购买 A 类目，以及是否在类目上为新客
,converted AS (
    SELECT
        --gus.ulabel,
        gus.cat_a,
        gus.seller_id,
        gus.group_type,
        gus.user_id,
        CASE WHEN cp.user_id IS NOT NULL THEN 1 ELSE 0 END AS is_converted,
        CASE WHEN cp.user_id IS NOT NULL AND npp.user_id IS NULL THEN 1 ELSE 0 END AS is_new_converted
    FROM group_users_seller gus
    LEFT JOIN conv_pay cp
        ON gus.user_id = cp.user_id
        AND cp.cate_name = gus.cat_a
        AND cp.seller_id = gus.seller_id
    LEFT JOIN new_period_pay npp
        ON gus.user_id = npp.user_id
        AND npp.cate_name = gus.cat_a
)
-- 汇总：按 ulabel + seller_id + group_type 聚合（跨 cat_a 去重用户）
SELECT
    --ulabel,
    seller_id,
    group_type,
    COUNT(DISTINCT user_id) AS group_user_cnt,
    COUNT(DISTINCT IF(is_converted=1, user_id, NULL)) AS converted_cnt,
    ROUND(
        CAST(COUNT(DISTINCT IF(is_converted=1, user_id, NULL)) AS DOUBLE)
        / CAST(COUNT(DISTINCT user_id) AS DOUBLE),
        6
    ) AS conversion_rate,
    COUNT(DISTINCT IF(is_new_converted=1, user_id, NULL)) AS new_converted_cnt,
    ROUND(
        CAST(COUNT(DISTINCT IF(is_new_converted=1, user_id, NULL)) AS DOUBLE)
        / NULLIF(CAST(COUNT(DISTINCT IF(is_converted=1, user_id, NULL)) AS DOUBLE), 0),
        6
    ) AS new_customer_ratio
FROM converted
GROUP BY seller_id, group_type
ORDER BY seller_id, group_type
LIMIT 10000;
