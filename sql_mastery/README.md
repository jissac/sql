## Securing Databases
### Creating a User
- In a production env, need to create user accounts (not all done in root)
- `CREATE USER` statement
- `IDENTIFIED BY` - password
### Viewing Users
- `SELECT * FROM mysql.user;`
- Can also view users on Adminstration panel
### Dropping Users
`DROP USER`
### Changing Passwords
- `SET PASSWORD FOR user = '1234'`
- can also change through 'Adminstration' password
### Granting Privileges
1. web/desktop application
    - use `GRANT` statement
      - `GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE`
2. admin
   - `ALL` is the highest level of privileges
### View Privileges
- `SHOW GRANTS FOR user`
### Revoking Privileges
- `REVOKE` command
## Indexing for High Performance
- Indexes are data structures that can speed up queries
### Cost of Indexes
- Increase size of the database
- slow down the writes (reserve indexes for performance critical queries)
  - DONT create indexes based on tables, but on QUERIES
  - indexes usually stored internally as Binary Trees
### Creating and Viewing
- `EXPLAIN`: type: ALL - MySQL scans all rows in table
- `CREATE INDEX idx_name ON table (column)`
- `SHOW INDEXES IN table`
### Prefix Indexes
- If column contains String like variable can consume lots of disk space, so use index prefix:
  - Char
  - Varchar
  - Text
  - Blob
### Full Text indexes
- implement fast search engine in the database, entire string column
- `CREATE FULLTEXT INDEX idx_title_body ON posts (title, body);
- `MATCH` function
### Composite Index
- should usually use composite indexes, b/c a query can have multiple filters
- common mistake (create indexes on each column instead of composite index)
#### Order of columns in composite index
- Put the most frquently used columns first
- put the columns with the higher cardinality (# of unique values in index) first
- but in general, put the more restrictive condition in query as index
- as queries grow, might need different indexes in different orders
  ### When Indexes are ignored
- When you use column in an expression, MySQL can't utilize index to its full potential
- Always isolate columns
### Sorting using indexes
- for a composite index, can sort by the order of items in index
  - cannot mix directions or add column
### Covering Indexes
- an index that covers everything a query needs
  - when designing index first
    - looks at `WHERE` clause: which items are most frequently there?
    - look at cols in `ORDER BY` clause
    - look at items in `SELECT` statement
### Index Maintenance
- Avoid duplicate indexes
- avoid redundant indexes
- Always check existing indexes before creating new ones!

## Designing Databases
How to design well-structured databases?
### Data Modeling
Process of creating a model for the data we want to store in a database
- 4 steps
  - 1. Understand and analyze the business requirements
  - 2. Build a conceptual model (visual representation)
  - 3. Build a logical model (tables, columns)
  - 4. Build a physical model (database mangaer, data types, etc)
### Conceptual Models
- Represents the entities and their relationships
- Entity Relationship diagrams
- UML - unified modeling language
### Logical Models
- abstract data model that shows entities and their relationships
- define datastructures (string, dateTime, etc)
### Physical Models
- implementation of a logical model for a specific database technology
- primary key: uniquely identifies each recor in a table
- composite primary key: multiple columns 
- foreign key: set of attributes in a table that refers to the primary key of another table. 
- In relational databases, only have one to one or one to many relationships. No many to many.
### Normalization
Process of reviewing design and making sure it follows some rules to avoid data duplication. 7 normal forms.
### 1st Normal Form (1NF)
- Each cell should have a single value and cannot have repeated columns
### 2nd Normal Form (2NF)
- Every table should describe one entity, and every column in that table should describe that entity
### 3rd Normal Form (3NF)
- A column in a table should not be derived from other columns
### Don't model the universe
- don't overgeneralize. Solve today's problems, not tomorrow's
## Summarizing Data
- Aggregate functions:`MAX()`, `MIN()`, `AVG()`, `SUM()`, `COUNT()`
- Functions will filter first from `WHERE` clause and then perform aggregation
- `GROUP BY` is always after `SELECT, FROM, WHERE` clauses, but before `ORDER BY` clause