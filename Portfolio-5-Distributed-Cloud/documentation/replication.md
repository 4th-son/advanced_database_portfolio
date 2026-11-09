# MarketLink – Database Replication

## 1. Introduction

Database replication is the process of maintaining multiple copies of database data across different database nodes. It improves data redundancy and supports high availability.

## 2. MongoDB Atlas Replication

MarketLink uses MongoDB Atlas to host its NoSQL database, `marketlink_nosql`.

The project uses an M0 Free cluster named `MarketLinkCluster`. According to MongoDB Atlas documentation, Free clusters have a fixed replication factor of three nodes.

MongoDB uses replica sets, which consist of a primary node and secondary nodes. The primary node processes write operations, while secondary nodes maintain copies of the primary's data.

## 3. Application to MarketLink

Replication is important to MarketLink because the system stores customer orders, payment summaries, vendor information and delivery records.

If a database node becomes unavailable, replica-set architecture supports continued database availability through an eligible secondary node being elected as primary.

## 4. Implementation and Limitations

MarketLink's database is deployed on MongoDB Atlas M0. Replication is managed by the Atlas service rather than manually configured by the student.

The M0 tier has a fixed three-node replication factor. It does not allow users to modify the replication factor or perform primary failover testing.

Therefore, this portfolio demonstrates managed cloud replication through the Atlas deployment and explains its operation rather than claiming to have manually configured or tested failover.

## 5. Conclusion

MongoDB Atlas replication provides an important foundation for database redundancy and availability. It helps MarketLink maintain reliable access to its database when individual database nodes experience failures.
