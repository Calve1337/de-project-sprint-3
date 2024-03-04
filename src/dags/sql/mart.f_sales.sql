DELETE FROM mart.f_sales WHERE EXISTS (
    SELECT * 
    FROM mart.f_sales 
    LEFT JOIN mart.d_calendar USING(date_id)
    WHERE  mart.f_sales.date_id = mart.d_calendar.date_id  
    AND mart.d_calendar.date_actual = '{{ds}}'
    );


insert into mart.f_sales (date_id, item_id, customer_id, city_id, quantity, payment_amount, status)
select  dc.date_id,
        uol.item_id,
        uol.customer_id,
        uol.city_id,
        uol.quantity,
        CASE
            WHEN status = 'refunded' THEN uol.payment_amount * -1 
            ELSE uol.payment_amount
        END AS payment_amount,
        status
from staging.user_order_log uol
left join mart.d_calendar as dc on uol.date_time::Date = dc.date_actual
where uol.date_time::Date = '{{ds}}';