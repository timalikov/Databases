/* 4.Select all warehouses with all columns.*/
SELECT * FROM warehouses;


/*5. Select all boxes with a value larger than $150.*/
SELECT * FROM boxes
WHERE value > 150;



/*6. Select all the boxes distinct by contents.*/
SELECT DISTINCT ON (contents)code, contents, value, warehouse
FROM boxes;


/*7. Select the warehouse code and the number of the boxes in each warehouse.*/
select warehouse, count(*) as boxes_number
from boxes
group by warehouse;


/*8.Same as previous exercise, but select only those warehouses where the number of the boxes is greater than 2. */
select warehouse, count(*) as boxes_number
from boxes
group by warehouse
having count(*) > 2;


/*9. Create a new warehouse in New York with a capacity for 3 boxes*/
INSERT INTO warehouses (code, location, capacity )
VALUES (6, 'New York', 3);

/*10. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.*/
INSERT INTO boxes (code, contents, value, warehouse )
VALUES ('H5RT', 'Papers', 200, 2);

/*11. Reduce the value of the third largest box by 15%.*/
update boxes
set value = value*0.85
where value = (select distinct value from boxes
                            order by value desc offset 3 limit 1);


/*12. Remove all boxes with a value lower than $150*/
delete from boxes
where value < 150;


/*13. Remove all boxes which is located in New York. Statement should return all deleted data*/
delete from boxes
where boxes.warehouse in (select code from warehouses
                                where location = 'New York')
returning *;
