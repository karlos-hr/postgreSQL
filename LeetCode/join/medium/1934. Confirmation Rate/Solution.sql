Create table If Not Exists Signups (user_id int, time_stamp datetime)
Create table If Not Exists Confirmations (user_id int, time_stamp datetime, action ENUM('confirmed','timeout'))
Truncate table Signups
insert into Signups (user_id, time_stamp) values ('3', '2020-03-21 10:16:13')
insert into Signups (user_id, time_stamp) values ('7', '2020-01-04 13:57:59')
insert into Signups (user_id, time_stamp) values ('2', '2020-07-29 23:09:44')
insert into Signups (user_id, time_stamp) values ('6', '2020-12-09 10:39:37')
Truncate table Confirmations
insert into Confirmations (user_id, time_stamp, action) values ('3', '2021-01-06 03:30:46', 'timeout')
insert into Confirmations (user_id, time_stamp, action) values ('3', '2021-07-14 14:00:00', 'timeout')
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-12 11:57:29', 'confirmed')
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-13 12:58:28', 'confirmed')
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-14 13:59:27', 'confirmed')
insert into Confirmations (user_id, time_stamp, action) values ('2', '2021-01-22 00:00:00', 'confirmed')
insert into Confirmations (user_id, time_stamp, action) values ('2', '2021-02-28 23:59:59', 'timeout')


SELECT s.user_id,
COALESCE(ROUND((SUM(CASE WHEN action = 'confirmed' THEN 1.00 END) / COUNT(*))::numeric, 2), 0) as confirmation_rate 
FROM Signups s 
LEFT JOIN Confirmations c ON c.user_id = s.user_id
GROUP BY (s.user_id)


/* BETTER SOLUTION */

SELECT s.user_id,
       ROUND(AVG(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END), 2) confirmation_rate
FROM Signups s
         LEFT JOIN confirmations c on s.user_id = c.user_id
GROUP BY s.user_id
