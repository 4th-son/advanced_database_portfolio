# MarketLink -- MongoDB Queries and Operations

## Portfolio 4: NoSQL and Advanced Data Models

**Database:** `marketlink_nosql`\
**Collection:** `orders`\
**Platform:** MongoDB Atlas Data Explorer

This document records the MongoDB filters, projection, and
CRUD/aggregation operations used in the MarketLink Portfolio 4 practical
exercises.

> **Note:** The first five filters and projection were run in MongoDB
> Atlas Data Explorer. The update and delete exercises were performed
> through the document editor and delete controls. Equivalent `mongosh`
> commands are included below for reference. Use only the commands you
> actually executed when describing your practical evidence.

------------------------------------------------------------------------

## 1. Find an order by order number

**Purpose:** Retrieve a specific order using its unique order number.

**Atlas Filter:**

``` javascript
{ "order_number": "ML-1001" }
```

**Equivalent `mongosh` command:**

``` javascript
db.orders.find({ order_number: "ML-1001" })
```

## 2. Find confirmed orders

**Purpose:** Retrieve orders whose status is `confirmed`.

**Atlas Filter:**

``` javascript
{ "order_status": "confirmed" }
```

**Equivalent `mongosh` command:**

``` javascript
db.orders.find({ order_status: "confirmed" })
```

## 3. Find an order using embedded customer information

**Purpose:** Search within the embedded `customer` document using dot
notation.

**Atlas Filter:**

``` javascript
{ "customer.email": "johnkamau@example.com" }
```

**Equivalent `mongosh` command:**

``` javascript
db.orders.find({ "customer.email": "johnkamau@example.com" })
```

## 4. Find orders containing a particular product

**Purpose:** Search the `items` array for an item whose product name is
`Wireless Mouse`.

**Atlas Filter:**

``` javascript
{ "items.product_name": "Wireless Mouse" }
```

**Equivalent `mongosh` command:**

``` javascript
db.orders.find({ "items.product_name": "Wireless Mouse" })
```

## 5. Find orders above KSh 5,000

**Purpose:** Retrieve orders whose `total_amount` is greater than 5,000.
The `$gt` operator means "greater than".

**Atlas Filter:**

``` javascript
{ "total_amount": { "$gt": 5000 } }
```

**Equivalent `mongosh` command:**

``` javascript
db.orders.find({ total_amount: { $gt: 5000 } })
```

## 6. Projection: return selected fields only

**Purpose:** Display only the order number, customer name, total amount,
and order status. `_id: 0` excludes MongoDB's automatically generated
document identifier.

**Atlas Filter:**

``` javascript
{ "order_number": "ML-1001" }
```

**Atlas Project field:**

``` javascript
{
  "_id": 0,
  "order_number": 1,
  "customer.full_name": 1,
  "total_amount": 1,
  "order_status": 1
}
```

**Equivalent `mongosh` command:**

``` javascript
db.orders.find(
  { order_number: "ML-1001" },
  {
    _id: 0,
    order_number: 1,
    "customer.full_name": 1,
    total_amount: 1,
    order_status: 1
  }
)
```

------------------------------------------------------------------------

## 7. Insert sample order documents

The practical exercise inserted three sample orders individually using
**Insert Document** in Atlas Data Explorer.

### 7.1 First order -- ML-1001

``` javascript
db.orders.insertOne({
  order_number: "ML-1001",
  customer: {
    customer_id: 1,
    full_name: "John Kamau",
    email: "johnkamau@example.com",
    phone: "+254712345678"
  },
  vendor: {
    vendor_id: 1,
    vendor_name: "TechWorld Nairobi"
  },
  items: [
    {
      product_id: 101,
      product_name: "Wireless Mouse",
      quantity: 2,
      unit_price: 1500
    },
    {
      product_id: 102,
      product_name: "Mechanical Keyboard",
      quantity: 1,
      unit_price: 2500
    }
  ],
  total_amount: 5500,
  payment: {
    method: "mpesa",
    status: "successful",
    transaction_reference: "MPESA123456"
  },
  delivery: {
    address: "Westlands, Nairobi",
    status: "pending"
  },
  order_status: "confirmed",
  order_date: new Date("2026-11-09T08:00:00Z")
})
```

### 7.2 Second order -- ML-1002

``` javascript
db.orders.insertOne({
  order_number: "ML-1002",
  customer: {
    customer_id: 2,
    full_name: "Mary Wanjiku",
    email: "mary@example.com",
    phone: "+254722345678"
  },
  vendor: {
    vendor_id: 2,
    vendor_name: "HomeStyle Kenya"
  },
  items: [
    {
      product_id: 201,
      product_name: "Office Chair",
      quantity: 1,
      unit_price: 8500
    },
    {
      product_id: 202,
      product_name: "Desk Lamp",
      quantity: 2,
      unit_price: 1200
    }
  ],
  total_amount: 10900,
  payment: {
    method: "mpesa",
    status: "successful",
    transaction_reference: "MPESA123457"
  },
  delivery: {
    address: "Kilimani, Nairobi",
    status: "dispatched"
  },
  order_status: "shipped",
  order_date: new Date("2026-11-08T10:00:00Z")
})
```

### 7.3 Third order -- ML-1003

``` javascript
db.orders.insertOne({
  order_number: "ML-1003",
  customer: {
    customer_id: 3,
    full_name: "Peter Mwangi",
    email: "peter@example.com",
    phone: "+254733456789"
  },
  vendor: {
    vendor_id: 1,
    vendor_name: "TechWorld Nairobi"
  },
  items: [
    {
      product_id: 103,
      product_name: "USB-C Hub",
      quantity: 1,
      unit_price: 3500
    }
  ],
  total_amount: 3500,
  payment: {
    method: "card",
    status: "pending",
    transaction_reference: "CARD123458"
  },
  delivery: {
    address: "Thika Road, Nairobi",
    status: "pending"
  },
  order_status: "pending",
  order_date: new Date("2026-11-09T08:00:00Z")
})
```

## 8. Retrieve all documents

**Purpose:** Display every document in the `orders` collection. An empty
filter `{}` matches all documents.

``` javascript
db.orders.find({})
```

## 9. Update an order's status

**Purpose:** Change order `ML-1003` from `pending` to `confirmed`.

**Equivalent `mongosh` command:**

``` javascript
db.orders.updateOne(
  { order_number: "ML-1003" },
  { $set: { order_status: "confirmed" } }
)
```

Verify the update:

``` javascript
db.orders.find({ order_number: "ML-1003" })
```

## 10. Delete a sample order

**Purpose:** Delete only the sample order `ML-1003` after the update
exercise.

**Equivalent `mongosh` command:**

``` javascript
db.orders.deleteOne({ order_number: "ML-1003" })
```

Verify that it was deleted:

``` javascript
db.orders.find({ order_number: "ML-1003" })
```

The verification query should return no matching document after a
successful deletion.

> The assignment exercise used the Atlas document editor and delete
> interface. The commands above show the equivalent MongoDB shell
> operations; do not claim that they were executed in `mongosh` unless
> you also ran them there.

------------------------------------------------------------------------

## 11. Aggregation: order count and sales by status

**Purpose:** Group orders by `order_status`, count the orders in each
group, and calculate the total sales amount for each status.

**Aggregation pipeline:**

``` javascript
[
  {
    $group: {
      _id: "$order_status",
      number_of_orders: { $sum: 1 },
      total_sales: { $sum: "$total_amount" }
    }
  }
]
```

**Equivalent `mongosh` command:**

``` javascript
db.orders.aggregate([
  {
    $group: {
      _id: "$order_status",
      number_of_orders: { $sum: 1 },
      total_sales: { $sum: "$total_amount" }
    }
  }
])
```

After inserting the three sample orders, changing `ML-1003` to
`confirmed`, and then deleting `ML-1003`, the expected grouped results
are:

  Order status     Number of orders   Total sales (KSh)
  -------------- ------------------ -------------------
  confirmed                       1               5,500
  shipped                         1              10,900

These figures assume the three sample documents were inserted
successfully and only `ML-1003` was deleted. Use the actual Atlas
aggregation output as your evidence.

------------------------------------------------------------------------

## 12. Concepts demonstrated

  -----------------------------------------------------------------------
  MongoDB feature                     What it demonstrates
  ----------------------------------- -----------------------------------
  `find()`                            Retrieving documents using filters

  Dot notation                        Querying fields inside embedded
                                      documents

  Array field query                   Searching values inside an array of
                                      embedded documents

  `$gt`                               Comparison using "greater than"

  Projection                          Returning selected fields

  `insertOne()`                       Inserting a document

  `updateOne()` and `$set`            Updating selected fields

  `deleteOne()`                       Deleting a matching document

  `aggregate()` and `$group`          Grouping documents and calculating
                                      totals
  -----------------------------------------------------------------------

## 13. Evidence checklist

Save screenshots of the actual Atlas operations in the Portfolio 4
screenshots folder.

-   [ ] Database and `orders` collection created.
-   [ ] First order document inserted and verified.
-   [ ] Five MongoDB filters executed.
-   [ ] Projection executed.
-   [ ] Second and third order documents inserted.
-   [ ] All three documents displayed.
-   [ ] `ML-1003` updated.
-   [ ] `ML-1003` deleted and deletion verified.
-   [ ] Aggregation pipeline and actual results displayed.

## 14. PostgreSQL and MongoDB in MarketLink

PostgreSQL is used for MarketLink's relational data, including
customers, vendors, products, orders, order items, payments, deliveries,
and inventory logs. MongoDB is used in this practical exercise to
demonstrate a document-oriented representation of an order, embedding
customer, vendor, item, payment, and delivery information in one
document.

The MongoDB model demonstrates flexible document structures and
convenient retrieval of related order information. The two databases
serve complementary purposes in the project.

------------------------------------------------------------------------

**Submission reminder:** Keep this file with your Portfolio 4
SQL/scripts or documentation, and include screenshots of your actual
Atlas results. Do not include database passwords, credentials, or
private connection strings in GitHub.
