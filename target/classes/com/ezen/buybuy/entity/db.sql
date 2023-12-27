select * from products;
select * from categories;
select * from orders;
select * from reviewproducts;
SELECT * FROM members;

SELECT m.member_id, m.name, m.phone, m.join_date
		FROM members m
		INNER JOIN applydealeraccount a ON m.member_id = a.member_id
		WHERE m.account_type = 'user';
INSERT INTO applydealeraccount (member_id)
VALUES ('asdf'), ('dealer01');
select * from applydealeraccount;
insert
SELECT m.member_id, m.name, m.phone, m.join_date
FROM members m
INNER JOIN applydealeraccount a ON m.member_id = a.member_id;

 SELECT
        COALESCE(SUM(orders.order_pcs), 0) AS total_quantity
    FROM
        ( SELECT '2023-12-07' + INTERVAL (tens.ten + units.unit) HOUR AS hourly_time
            FROM
                (SELECT 0 AS unit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) units,
                (SELECT 0 AS ten UNION ALL SELECT 10 UNION ALL SELECT 20) tens
            WHERE '2023-12-07' + INTERVAL (tens.ten + units.unit) HOUR BETWEEN '2023-12-07' AND '2023-12-07' + INTERVAL 23 HOUR
        ) all_hours
    LEFT JOIN
        orders ON DATE_FORMAT(orders.order_date, '%Y-%m-%d %H') = DATE_FORMAT(all_hours.hourly_time, '%Y-%m-%d %H')
    GROUP BY '2023-12-07', hourly_time
    ORDER BY hourly_time;