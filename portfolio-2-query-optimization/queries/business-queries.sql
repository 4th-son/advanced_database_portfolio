
-- MARKETLINK: PORTFOLIO 2 TEST DATA

-- 1. Insert customers
INSERT INTO customers (full_name, email, phone)
SELECT
    'Customer ' || n,
    'customer' || n || '@marketlink.test',
    '070000' || LPAD(n::TEXT, 4, '0')
FROM generate_series(1, 100) AS n;

-- 2. Insert vendors
INSERT INTO vendors (
    vendor_name, email, phone, business_address
)
SELECT
    'Vendor ' || n,
    'vendor' || n || '@marketlink.test',
    '071000' || LPAD(n::TEXT, 4, '0'),
    'Nairobi, Kenya'
FROM generate_series(1, 15) AS n;

-- 3. Insert categories
INSERT INTO categories (category_name, description)
SELECT
    'Category ' || n,
    'MarketLink product category ' || n
FROM generate_series(1, 10) AS n;

-- 4. Insert products
INSERT INTO products (
    vendor_id,
    category_id,
    product_name,
    sku,
    description,
    price,
    stock_quantity
)
SELECT
    ((n - 1) % 15) + 1,
    ((n - 1) % 10) + 1,
    'Product ' || n,
    'ML-SKU-' || n,
    'MarketLink sample product ' || n,
    100 + (n % 50000),
    10 + (n % 100)
FROM generate_series(1, 20000) AS n;

-- 5. Insert orders
INSERT INTO orders (
    customer_id,
    order_date,
    total_amount,
    order_status
)
SELECT
    ((n - 1) % 100) + 1,
    CURRENT_TIMESTAMP - (n * INTERVAL '1 hour'),
    0,
    CASE
        WHEN n % 5 = 0 THEN 'delivered'
        WHEN n % 5 = 1 THEN 'pending'
        WHEN n % 5 = 2 THEN 'confirmed'
        WHEN n % 5 = 3 THEN 'processing'
        ELSE 'shipped'
    END
FROM generate_series(1, 5000) AS n;

-- 6. Insert order items
INSERT INTO order_items (
    order_id,
    product_id,
    quantity,
    unit_price
)
SELECT
    n,
    ((n * 2 + j) % 20000) + 1,
    (j + 1),
    100 + (((n * 2 + j) % 20000) % 50000)
FROM generate_series(1, 5000) AS n
CROSS JOIN generate_series(1, 2) AS j;

-- 7. Update order totals
UPDATE orders o
SET total_amount = (
    SELECT SUM(oi.quantity * oi.unit_price)
    FROM order_items oi
    WHERE oi.order_id = o.order_id
);

-- Update PostgreSQL statistics
ANALYZE;
