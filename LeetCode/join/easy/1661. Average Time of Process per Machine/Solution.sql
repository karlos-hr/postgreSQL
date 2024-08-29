Create table If Not Exists Activity (machine_id int, process_id int, activity_type ENUM('start', 'end'), timestamp float)
Truncate table Activity
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '0', 'start', '0.712')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '0', 'end', '1.52')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '1', 'start', '3.14')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '1', 'end', '4.12')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '0', 'start', '0.55')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '0', 'end', '1.55')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '1', 'start', '0.43')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '1', 'end', '1.42')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '0', 'start', '4.1')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '0', 'end', '4.512')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '1', 'start', '2.5')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '1', 'end', '5')



SELECT a1.machine_id,
ROUND( (SUM(a2.timestamp - a1.timestamp)/COUNT(DISTINCT a1.process_id ))::numeric , 3) as processing_time 
FROM Activity a1 
INNER JOIN Activity a2 ON a2.machine_id = a1.machine_id AND a2.process_id = a1.process_id AND a2.activity_type = 'end'
GROUP BY a1.machine_id


/* BETTER SOLUTION */
select a.machine_id, round(avg(b.timestamp - a.timestamp)::numeric,3) as processing_time 
from activity a, activity b
where a.machine_id = b.machine_id and a.process_id = b.process_id
and a.activity_type = 'start'
and b.activity_type = 'end'
group by a.machine_id;