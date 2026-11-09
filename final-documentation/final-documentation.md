# MIT 8103 – Advanced Database Systems

## Individual Practical Database Portfolio

**Academic Session:** 2026/2027 – First Semester  
**Student:** Michael Ogozi  
**Programme:** Master of Information Technology  
**Selected Case Study:** MarketLink – Multi-Vendor E-commerce and Inventory Management System  
**Database Technologies:** PostgreSQL and MongoDB Atlas  
**GitHub Repository:** https://github.com/4th-son/advanced_database_portfolio/tree/main/portfolio-1-database-design

---

## 1. Introduction and Case Study

This portfolio presents the design, implementation, optimisation and management of a database solution for **MarketLink**, a simulated multi-vendor e-commerce and inventory management system.

MarketLink provides a platform where customers purchase products from different vendors. The system supports customer registration, vendor management, product listings, order processing, payments, deliveries and inventory tracking.

The main database users include customers, vendors, administrators and delivery personnel. The system stores customer details, vendor information, product records, orders, payments, delivery information and inventory movements.

The project uses PostgreSQL for structured relational data and MongoDB Atlas to demonstrate document-oriented data storage. The same MarketLink case study is maintained across all five portfolio activities.

## 2. Portfolio Activities and Implementation

### Portfolio 1: Database Design and Modelling

The first portfolio involved analysing MarketLink's business requirements and designing a relational database structure using PostgreSQL.

The database, named `marketlink_db`, was implemented using pgAdmin 4. It contains ten related tables: `customers`, `vendors`, `categories`, `products`, `orders`, `order_items`, `payments`, `deliveries`, `delivery_items` and `inventory_logs`.

Primary keys, foreign keys, unique constraints, check constraints and other integrity rules were applied to maintain data accuracy and enforce relationships between tables.

The design also considered database normalisation up to Third Normal Form (3NF), reducing unnecessary data duplication and improving data integrity. The ER diagram and relational schema illustrate the relationships between MarketLink's entities.

**Evidence:** ER diagram, relational schema, database tables and constraints.

### Portfolio 2: Query Processing and Optimisation

The second portfolio focused on retrieving useful business information and improving query performance using PostgreSQL.

Six business queries were developed and executed. They included retrieving available products, listing customers and their orders, identifying top-selling products, calculating vendor sales, identifying top-spending customers and finding products with low stock levels.

Query execution plans were examined using `EXPLAIN` and `EXPLAIN ANALYZE`. Indexes were also introduced on relevant columns to demonstrate how indexing can improve data retrieval and query execution.

The exercise provided practical experience in SQL joins, aggregation, filtering, sorting, indexing and execution-plan interpretation.

**Evidence:** SQL scripts, query results, execution plans, index definitions and performance screenshots.

### Portfolio 3: Transactions and Concurrency

The third portfolio examined transaction management and concurrency control in PostgreSQL.

Practical exercises demonstrated transaction commitment using `COMMIT` and transaction reversal using `ROLLBACK`. Isolation levels, including `READ COMMITTED` and `REPEATABLE READ`, were explored using separate database sessions.

The exercise also demonstrated row-level locking with `SELECT ... FOR UPDATE` to control simultaneous access to product records.

These activities illustrated how transaction management helps maintain data integrity when multiple users perform operations on the database. In MarketLink, these concepts are particularly important when customers place orders and product stock is updated.

**Evidence:** Transaction SQL scripts, outputs from database sessions and screenshots demonstrating commit, rollback, isolation and locking.

### Portfolio 4: NoSQL and Advanced Data Models

The fourth portfolio introduced MongoDB as a document-oriented database technology.

A MongoDB Atlas cluster named `MarketLinkCluster` was created. Within it, the `marketlink_nosql` database and `orders` collection were established.

An order document was inserted to demonstrate how customer information, vendor information, purchased items, payment details and delivery information can be represented in a flexible document structure.

MongoDB queries were executed using `find()` to retrieve orders by order number, status, customer email, product name and total amount. Projection was also used to return selected fields from an order document.

The exercise demonstrated document insertion, nested documents, arrays, filtering and field projection. MongoDB provides a flexible approach to storing order information, complementing PostgreSQL's structured relational model.

**Evidence:** Atlas database and collection screenshots, inserted order document, MongoDB query results and projection output.

### Portfolio 5: Distributed and Cloud Database Exercise

The fifth portfolio explored cloud database deployment and distributed database concepts using MongoDB Atlas.

The MarketLink NoSQL database was deployed on an Atlas M0 Free cluster. The exercise examined replication, sharding, availability and consistency.

Replication was studied through MongoDB replica-set architecture, where a primary node handles writes and secondary nodes maintain replicated copies of the data. The documentation explains how automatic elections can support availability when a primary node becomes unavailable.

Sharding was examined as a horizontal scaling approach involving shards, a `mongos` query router and configuration servers. A hashed `order_number` shard key was proposed for the MarketLink orders collection to support more even data distribution. However, sharding was not implemented because the M0 Free tier does not support sharded clusters.

Availability and consistency were also examined, including the roles of replica sets, automatic failover, read concern, write concern and read preference. The limitations of the Free deployment were acknowledged, particularly the inability to perform manual failover testing.

**Evidence:** Atlas cluster deployment, database screenshots and technical documentation covering replication, sharding, availability and consistency.

## 3. Technical Reflection and Lessons Learned

Working on this portfolio improved my understanding of how database systems are designed and managed in practical applications.

One important lesson was the need to design database relationships carefully before implementation. Developing the MarketLink relational schema helped me understand the importance of primary keys, foreign keys, constraints and normalisation.

The query optimisation exercises demonstrated that writing a query that returns the correct result is not the only consideration. Query execution plans and appropriate indexing are also important when developing systems that may handle large amounts of data.

The transaction and concurrency exercises improved my understanding of how databases manage simultaneous operations. This is particularly relevant to e-commerce applications where several customers may attempt to purchase products while inventory quantities are changing.

Working with MongoDB also helped me understand the difference between relational and document-oriented databases. I learned that embedded documents can make related information easier to retrieve, while relational databases provide structured relationships and integrity constraints.

Finally, the MongoDB Atlas exercises introduced me to cloud database deployment and distributed database concepts. I learned that replication, sharding, availability and consistency are important considerations when designing scalable database systems. A key challenge was working within the limitations of the free cloud deployment, which required documenting some advanced configurations theoretically rather than implementing them directly.

Overall, the portfolio strengthened my practical understanding of database design, SQL, query optimisation, transaction management, NoSQL databases and cloud database architecture.

## 4. References

1. PostgreSQL Global Development Group. _PostgreSQL Documentation_. https://www.postgresql.org/docs/
2. MongoDB, Inc. _MongoDB Manual_. https://www.mongodb.com/docs/manual/
3. MongoDB, Inc. _MongoDB Atlas Documentation_. https://www.mongodb.com/docs/atlas/
4. MIT 8103 Advanced Database Systems. _2026/2027 First Semester Continuous Assessment Brief_.

## 5. AI Use Declaration

OpenAI ChatGPT was used as a learning aid during this portfolio. It assisted with understanding database concepts, providing step-by-step guidance, explaining SQL and MongoDB operations, troubleshooting practical exercises and organising technical documentation.

The database activities were carried out and tested by the student using PostgreSQL/pgAdmin 4 and MongoDB Atlas. The student remains responsible for reviewing the submitted work, verifying its accuracy, understanding the implementation and explaining the results.
