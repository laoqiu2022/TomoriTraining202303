SELECT p.monarch as '勢力', COUNT(*) as '合計'
FROM city c
INNER JOIN political p
ON c.monarch_no = p.no
GROUP BY p.monarch
;
