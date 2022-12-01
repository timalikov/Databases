select * from dealer;


-- 1)
-- a.combine each row of dealer table with each row of client table
select dealer.id, dealer.name, location, charge, client.id, client.name, client.city, client.priority
from dealer
inner join client on dealer.id = client.dealer_id;



-- b.find all dealers along with client name, city, grade, sell number, date, and amount
select distinct * from dealer d
join client c on d.id = c.dealer_id
join sell s on d.id = s.dealer_id and c.id = s.client_id;



-- c.find the dealer and client who belongs to same city
select d.name, c.name, city from dealer d
join client c on d.location = c.city;


-- d.find sell id, amount, client name, city those sells where sell amount exists between100 and 500
select s.id,s.amount,client.name,client.city
from (select * from sell where amount > 100 and amount<500) as s
inner join client on client.id = s.client_id;


-- e)
select d.id,d.name,d.location,d.charge,count(*)
from dealer d
full outer join client c on d.id = c.dealer_id
group by d.id;


-- f)
select d.name,d.charge,c.name,c.city
from dealer d
inner join client c on d.id = c.dealer_id;


-- g)
select c.name,c.city,d.name,d.charge
from client c
inner join dealer d on d.charge>0.12 and c.dealer_id = d.id;


-- h)
select c.name,c.city,s.id,s.date,s.amount,d.name,d.charge
from client c
full outer join sell s on c.id = s.client_id
full outer join dealer d on d.id = c.dealer_id;


-- i)
select *
from client c
left outer join dealer d on d.id = c.dealer_id
inner join sell s on c.id = s.client_id or s.amount>2000 and c.priority is not null ;



--2)
-- a)
select avg(amount),sum(amount),count(distinct client_id)
from sell;


-- b)
select date,sum(amount) as total
from sell
group by date
order by total desc
limit 5;


-- c)
select dealer_id,count(id),avg(amount),sum(amount)
from sell
group by dealer_id;


-- d)
select d.name,sum(d.charge*s.amount)
from dealer d
inner join sell s on d.id = s.dealer_id
group by d.name;


-- e)
select location,count(s.id) as sale,avg(amount),sum(amount)
from sell s
inner join dealer d on d.id = s.dealer_id
group by location;


-- f)
select city,count(s.id) as sale,avg(amount),sum(amount)
from sell s
inner join client c on c.id = s.client_id
group by city;


-- g)
select distinct c.city,c.total
from (select city,sum(amount) as total
      from sell s
          inner join client c on c.id = s.client_id
      group by city) as c,
     (select location,sum(amount) as total
      from sell s
          inner join dealer d on d.id = s.dealer_id
      group by location) as l
where c.city = l.location and c.total > l.total; n