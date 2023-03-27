create view caocao_v3 as
select 
	g.no,
	g.name,
	g.status,
	g.control + g.power + g.intelligence + g.politics + g.glamour as fiveData,
	g.control,
	g.power,
	g.intelligence,
	g.politics,
	g.glamour
from
	generals g
	inner join city c
		on g.owner= c.name join political p
			on c.monarch_no = p.no
where 
	p.no = 0
	and g.status not in ('未登場', '未発見', '在野', '死亡')
order by fiveData desc;
