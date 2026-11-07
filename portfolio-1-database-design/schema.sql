
-- =====================================================
-- MARKETLINK
-- MIT 8103: ADVANCED DATABASE SYSTEMS
-- PORTFOLIO 1: DATABASE DESIGN AND MODELLING
-- PostgreSQL relational schema
-- =====================================================

-- 1. CUSTOMERS
CREATE TABLE customers (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. VENDORS
CREATE TABLE vendors (
    vendor_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    vendor_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    business_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. PRODUCT CATEGORIES
CREATE TABLE categories (
    category_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- 4. PRODUCTS
CREATE TABLE products (
    product_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    vendor_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    sku VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    price NUMERIC(12,2) NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER NOT NULL DEFAULT 0
        CHECK (stock_quantity >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_product_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors(vendor_id),

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

-- 5. ORDERS
CREATE TABLE orders (
    order_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(12,2) NOT NULL DEFAULT 0
        CHECK (total_amount >= 0),
    order_status VARCHAR(30) NOT NULL DEFAULT 'pending'
        CHECK (order_status IN (
            'pending', 'confirmed', 'processing',
            'shipped', 'delivered', 'cancelled'
        )),

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 6. ORDER ITEMS
CREATE TABLE order_items (
    order_item_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12,2) NOT NULL
        CHECK (unit_price >= 0),

    CONSTRAINT fk_item_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_item_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT uq_order_product
        UNIQUE (order_id, product_id)
);

-- 7. PAYMENTS
CREATE TABLE payments (
    payment_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    order_id INTEGER NOT NULL,
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(30) NOT NULL
        CHECK (payment_method IN (
            'mpesa', 'card', 'bank_transfer', 'cash'
        )),
    payment_status VARCHAR(30) NOT NULL DEFAULT 'pending'
        CHECK (payment_status IN (
            'pending', 'successful', 'failed', 'refunded'
        )),
    transaction_reference VARCHAR(100) UNIQUE,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

-- 8. DELIVERIES
CREATE TABLE deliveries (
    delivery_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    order_id INTEGER NOT NULL,
    vendor_id INTEGER NOT NULL,
    delivery_address TEXT NOT NULL,
    delivery_status VARCHAR(30) NOT NULL DEFAULT 'pending'
        CHECK (delivery_status IN (
            'pending', 'dispatched', 'in_transit',
            'delivered', 'failed'
        )),
    tracking_number VARCHAR(100) UNIQUE,
    dispatched_at TIMESTAMP,
    delivered_at TIMESTAMP,

    CONSTRAINT fk_delivery_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_delivery_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendors(vendor_id),

    CONSTRAINT uq_order_vendor_delivery
        UNIQUE (order_id, vendor_id)
);

-- 9. DELIVERY ITEMS
CREATE TABLE delivery_items (
    delivery_item_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    delivery_id INTEGER NOT NULL,
    order_item_id INTEGER NOT NULL,
    quantity_shipped INTEGER NOT NULL
        CHECK (quantity_shipped > 0),

    CONSTRAINT fk_delivery_item_delivery
        FOREIGN KEY (delivery_id)
        REFERENCES deliveries(delivery_id),

    CONSTRAINT fk_delivery_item_order_item
        FOREIGN KEY (order_item_id)
        REFERENCES order_items(order_item_id),

    CONSTRAINT uq_delivery_order_item
        UNIQUE (delivery_id, order_item_id)
);

-- 10. INVENTORY LOGS
CREATE TABLE inventory_logs (
    log_id INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    product_id INTEGER NOT NULL,
    quantity_change INTEGER NOT NULL
        CHECK (quantity_change <> 0),
    movement_type VARCHAR(30) NOT NULL
        CHECK (movement_type IN (
            'stock_in', 'sale', 'return',
            'adjustment', 'damaged'
        )),
    notes TEXT,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

