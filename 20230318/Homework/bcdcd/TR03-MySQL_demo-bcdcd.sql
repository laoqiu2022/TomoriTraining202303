/*第一题：修改诸葛亮状态*/
UPDATE generals SET status='一般' WHERE `no`=288;
select * from generals where `no`=288;

/*第二题：查询曹操领地个数*/
CREATE VIEW Caocao_city_count AS
SELECT p.monarch , count(*)
FROM political p INNER JOIN city c
ON p.no = c.monarch_no
WHERE c.monarch_no = 0;

/*第三题：查询各势力的领地个数*/
CREATE VIEW monarch_city_count AS
SELECT p.monarch ,count(*)
FROM political p INNER JOIN city c
ON p.no = c.monarch_no
WHERE p.no IS NOT 99
GROUP BY p.monarch;

/*第四题：查询曹操麾下将领五维数据*/
CREATE VIEW Caocao_generals_fiveData AS
SELECT `no`,name,status,control+power+intelligence+politics+glamour AS fiveData,control,power,intelligence,politics,glamour
FROM generals
WHERE owner IN (
    SELECT c.name
    FROM city c INNER JOIN political p
    ON c.monarch_no = p.no
    WHERE p.no = 0
) AND status NOT IN('未登場', '未発見', '在野', '死亡')
ORDER BY fiveData DESC;

/*第五题：查询各势力手下五维数据前五将领*/
/*1.先创一个视图，查询各势力手下将领五维数据*/
CREATE VIEW monarch_generals_fiveData AS
SELECT p.no AS '勢力番号',p.monarch AS '君主',g.name AS '武将名',control+power+intelligence+politics+glamour AS '五囲',
control AS '統御',power AS '武力',intelligence AS '智力',politics AS '政治',glamour AS '魅力'
FROM generals g INNER JOIN (
    SELECT c.name,p.monarch,p.no
    FROM city c INNER JOIN political p
    ON c.monarch_no = p.no
) p
ON g.owner = p.name
WHERE g.status NOT IN('未登場', '未発見', '在野', '死亡')
ORDER BY 勢力番号 ,五囲 DESC;

/*2.筛选前五*/
CREATE VIEW monarch_generals_fiveData_Rank5 AS
SELECT * 
FROM monarch_generals_fiveData m1
WHERE 5 > (
    SELECT COUNT(*) 
    FROM monarch_generals_fiveData m2
    WHERE m2.勢力番号 = m1.勢力番号
    AND m2.五囲 > m1.五囲
)
ORDER BY m1.勢力番号,m1.五囲 DESC;


