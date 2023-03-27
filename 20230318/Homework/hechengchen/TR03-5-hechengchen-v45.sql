create view best5_v45 as

select
	sub2.no as '势力番号',
	sub2.monarch as '君主',
	sub2.name as '武将名',
	sub2.fivedata as '五维',
	sub2.control as '控制',
	sub2.power as '武力',
	sub2.intelligence as '智力',
	sub2.politics as '政治',
	sub2.glamour as '魅力'
from
(select 
	sub1.*,       
	row_number()over (partition by sub1.no order by sub1.fivedata desc) as rn
from
(select 
	p.no,
	p.monarch,
	g.name,
	g.control + g.power + g.intelligence + g.politics + g.glamour as fivedata,
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
	g.status not in ('未登場', '未発見', '在野', '死亡')
) sub1
) sub2

where sub2.rn <=5
order by 
sub2.no,
sub2.fivedata desc;