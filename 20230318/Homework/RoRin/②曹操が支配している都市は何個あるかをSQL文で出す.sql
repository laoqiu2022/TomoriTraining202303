SELECT '曹操' as '勢力', COUNT(*) as '合計'
FROM city c
INNER JOIN political p
ON c.monarch_no = p.no
WHERE p.monarch = '曹操'
;
