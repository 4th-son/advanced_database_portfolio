Constraints are rules enforced by the database to protect data integrity.

We have implemented several types.
Constraint MarketLink example Purpose
PRIMARY KEY customer_id Unique identification
FOREIGN KEY customer_id in orders Referential integrity
NOT NULL product_name Prevents missing required data
UNIQUE email Prevents duplicate email addresses
CHECK price >= 0 Prevents negative prices
DEFAULT order_status = pending Supplies a default value
