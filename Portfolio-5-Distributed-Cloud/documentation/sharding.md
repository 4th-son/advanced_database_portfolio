# MarketLink – Database Sharding

## 1. Introduction

Database sharding is a horizontal scaling technique that distributes data across multiple database servers called shards. It allows a database system to handle increasing data volumes and workloads.

## 2. Application to MarketLink

MarketLink is a multi-vendor e-commerce platform that stores customers, vendors, products, orders, payments and delivery information.

As the platform grows, the number of orders and database operations may increase significantly. A single database server may eventually become a performance bottleneck.

Sharding would allow MarketLink to distribute its orders across multiple database servers.

## 3. Proposed Shard Key

For the MarketLink `orders` collection, the proposed shard key is:

```javascript
{ "order_number": "hashed" }
```

A hashed shard key distributes documents using hashed values of the selected field. Since each MarketLink order has a distinct order number, this approach is intended to distribute order records across multiple shards.

It also supports targeted queries that include the order number.

## 4. Sharded Architecture

The proposed architecture consists of:

- Shards that store portions of the orders collection.
- A mongos router that directs database requests.
- Config servers that maintain cluster metadata.

Each shard can also use replication to improve availability.

## 5. Implementation Limitations

The current MarketLink database is hosted on MongoDB Atlas M0 Free.

Atlas Free clusters do not support sharded deployments. Sharding is supported on Atlas dedicated clusters starting from M30.

Therefore, this exercise presents a proposed sharding architecture and shard key design rather than an actual sharded deployment.

## 6. Conclusion

Sharding would help MarketLink scale as its number of customers, vendors and orders increases. The proposed hashed order-number shard key aims to distribute order documents across multiple database servers while supporting targeted order retrieval.
