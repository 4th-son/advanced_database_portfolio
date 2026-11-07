-- Index for searching products by category
CREATE INDEX idx_products_category_id
ON products(category_id);

-- Index for retrieving orders by customer and date
CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date DESC);

-- Index for searching order items by product
CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

-- Index for retrieving orders by date
CREATE INDEX idx_orders_order_date
ON orders(order_date);