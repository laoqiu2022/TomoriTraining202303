--①諸葛亮の身分を「一般」に更新するSQL文を作る
--直接用已知的no调取
UPDATE generals SET status = '一般' WHERE no = 288;


--不明白为什么跑不起来的版本
DECLARE @a int , @b varchar(10);
SET @b:= '諸葛亮';
SET @a:= (SELECT no FROM generals WHERE name = @b);
UPDATE generals SET status = '一般' WHERE no = @a;

--②曹操が支配している都市は何個あるかをSQL文で出す
SELECT p.monarch AS '势力',COUNT(*) AS count
--设置需要显示的字段
FROM city c,political p
--指定来源
WHERE c.monarch_no IN(
    SELECT p.no
    WHERE p.no = 0
    --筛选对象字段为0
)

--③それぞれ勢力が支配している都市は何個あるかをSQL文で一覧する
CREATE VIEW Homework3 AS
SELECT a.monarch AS '勢力', COUNT(b.monarch_no) AS '֧支配都市個数'
FROM political a
LEFT JOIN city b ON a.no = b.monarch_no
GROUP BY a.monarch
ORDER BY a.no

--④曹操配下の武将の五囲が高い順で一覧する
CREATE VIEW Homework4 AS
--创建view
SELECT g.no, g.name, g.status,
    (g.control + g.power + g.glamour + g.intelligence + g.politics) AS fiveData,
    g.control , g.power , g.glamour , g.politics ,g.intelligence
--选择需要显示的列名

FROM generals g
--从武将数据中选出

INNER JOIN city c 
    on g.owner = c.name
    JOIN political p on c.monarch_no = p.no
--将C表数据与G表将武将所属地关联起来，再将对应的所属地的归属势力代号的关联起来
--实现了武将和所属势力的关联
    
WHERE c.monarch_no = 0
--筛选出势力代码为0 即曹操手下的武将

AND g.status NOT IN ('未登場', '未発見', '在野', '死亡')
--剔除出异常状态数据

ORDER BY fiveData DESC;
--按照五维合排序，从大到小

--⑤各勢力の配下の武将の五囲が高い順のTop5を一覧する
CREATE VIEW Homework5 AS
SELECT p.no AS '勢力番号',
    p.monarch AS '君主',
    g.name AS '武将名',
    (g.control + g.power + g.intelligence + g.politics + g.glamour) AS '五囲',
    g.control AS '統御',
    g.power AS '武力',
    g.intelligence AS '智力',
    g.politics AS '政治',
    g.glamour AS '魅力'
FROM generals g
INNER JOIN city c ON g.owner = c.name 
    JOIN political p ON c.monarch_no = p.no

WHERE g.no IN (SELECT no FROM generals WHERE owner IN 
                 (SELECT name FROM city WHERE monarch_no = p.no)
                 AND status NOT IN ('未登場', '未発見', '在野', '死亡')
                 ORDER BY (control + power + intelligence + politics + glamour) DESC
                 LIMIT 5)
--插入了一个子查询
--子查询部分使用了主查询中的p.no值作为条件，查询出对应势力下五维最高的五个武将的编号，然后在主查询中使用IN语句筛选出这五个武将的信息
--直接筛除掉了不符合条件的武将信息

ORDER BY p.no,五囲 DESC;