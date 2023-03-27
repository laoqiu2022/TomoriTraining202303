SELECT
  g.no as '武将ID',
  g.name as '武将名',
  g.status as '身分',
  g.control + g.power + g.intelligence + g.politics + g.glamour as 'faveDate',
  g.control as '統御',
  g.power as '武力',
  g.intelligence as '智力',
  g.politics as '政治',
  g.glamour as '魅力'
FROM
  generals g 
  INNER JOIN city c ON g.owner = c.name 
  INNER JOIN political p ON c.monarch_no = p.no 
WHERE
  p.monarch = '曹操' 
  AND g.status NOT IN ('未登場', '未発見', '在野', '死亡')
ORDER BY
  g.control + g.power + g.intelligence + g.politics + g.glamour DESC
;

