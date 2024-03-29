ALTER TABLE mart.f_sales;
ADD COLUMN status VARCHAR(30) NOT NULL;
DEFAULT 'shipping';

ALTER TABLE staging.user_order_log
ADD COLUMN status VARCHAR(30);

CREATE TABLE IF NOT EXISTS mart.f_customer_retention (
    new_customers_count INT,
    returning_customers_count INT,
    refunded_customer_count INT,
    period_name VARCHAR(30),
    period_id INT,
    item_id VARCHAR(30),
    new_customers_revenue NUMERIC(14, 3),
    returning_customers_revenue NUMERIC(14, 3),
    customers_refunded INT,
    CONSTRAINT f_customer_retention_pk PRIMARY KEY (period_id, item_id)
);