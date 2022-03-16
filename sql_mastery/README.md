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
- Use `HAVING` clause to filter data after grouping (columns for conditions must be included in `SELECT` clause), use `WHERE` to filter before grouping
- Rule of thumb, when you have an aggregate function, you should group by all cols in `SELECT` clause
- `ROLLUP` operator captures summary values for each group and also entire result set

## Writing Complex Queries
- Subqueries can be in many places (inside `WHERE, FROM, SELECT` clauses)
- reserve subqueries in `FROM` clause for simple queries, can use VIEWS instead
- the `IN` operator returns a list of values
### Subqueries vs Joins
- can use both, choose the one that's more readable for the problem being solved
- `ALL` operator looks at each row and finds max, similar to `MAX` function
- `= ANY(..)` is equivalent to the `IN` operator
### Correlated Subqueries
- When the inner subquery references a table in the outer query
- `EXISTS` vs `IN`: `IN` returns a list, `EXISTS` subquery doesn't return a result to the outer query, it returns an indication of whether any rows in subquery matches condition
- more efficient to use `EXISTS` if you get back a large list using `IN`
  
## Essential MySQL functions
- Numeric functions: `ROUND, TRUNCATE, CEILING, FLOOR, ABS, RAND`
- String functions: `LENGTH, UPPER, LOWER`
- removing space: `LTRIM, RTRIM, TRIM`
- `LEFT('kindergarten', 4)` , `RIGHT('kindergarten', 6)`
- `SUBSTRING('kindergarten', 3, 5)`
- `LOCATE('n','kindergarten')` returns position of first occurance of character
- `REPLACE('Kindergarten','garten', 'garden')`
- `CONCAT('first','last')`
- `NOW` current date and time
- `CURDATE` date, without time
- `CURETIME` time
- `YEAR` returns the year `YEAR(NOW())`, also `MONTH, HOUR, MINUTE, SECOND`
- `DAYNAME` and `MONTHNAME`
- `EXTRACT`-pull out specific value, common to sql language across dbms: `EXTRACT(YEAR FROM NOW())`
### Formatting Dates and Times
- In MySQL, time is in year-month-day format
- `DATE_FORMAT(NOW(), '%M %d %Y)`
- `TIME_FORMAT(NOW(), '%H:%i %p')`
### Calculating Dates and Times
- `DATE_ADD(NOW(), INTERVAL 1 DAY)`
- `DATE_SUB`
- `DATEDIFF('2020-01-05', '2020-02-03')`
- `TIME_TOP_SEC`: seconds elapsed since midnight
### IFNULL and COALESCE
- with `IFNULL` you provide value if value is null `IFNULL(col_name, '...')`
- with `COALESCE` fn, you supply a list of values and it will return first non-null value
### IF and CASE
- `IF(condition, true, false)` for two options
- `CASE` for more than two options
- `CASE WHEN condition THEN ELSE '...' END`


## Views
Views simplify the query process by providing a view to the underlying data/tables
- `CREATE OR REPLACE VIEW ... AS`
- can update views (updateable view) if they don't have aggregate fns, distinct, group by/having, union in them
- `WITH CHECK OPTION` prevents modififed rows from being deleted from an updated view
- Views reduce impact of changes by providing abstraction of underlying table
- Views restrict access to the data - security


## Stored Procedures
- SQL code should be outside application code
- Use stored procedures to store and organize SQL code
- provide data security
- `CREATE PROCEDURE ...() BEGIN SELECT...; END$$`
### Validating Stored Procedures
- validating is important, but do most of the validation at the appication/input level
- check data types, inputs
- user/session defined variable, prefix with `@` sign
- `SET @variable = 0`
- Local variable: variables in stored procedures, use `DECLARE` clause
### User Functions
- Similar to stored procedures except can only return a single value, not table, list, rows, etc


## Triggers and Events
- Trigger: a block of Sql code that automatically gets executed before or after an insert, update, or delete statement
- `CREATE TRIGGER table_after_operation`
- `SHOW TRIGGERS`
- `DROP TRIGGER IF EXISTS`
- Event: a task / block of Sql code that gets executing according to a schedule
- `CREATE EVENT ON SCHEDULE DO BEGIN`


## Transactions and Concurrency
- Transaction: group of SQL statements that represent a single unit of work
- Transactions follow ACID
    - A: Atomicity - transactions are like atoms - unbreakable, each transaction is a single unit of work. Either all statments get executed successfuly and changes are committed or transaction is rolled back an changes undone
    - C: consistency - db will always remain in a consistent state
    - I: isolation - transactions are protected from each other if they try to update same data, only one transaction at a time
    - D: durability - once a transaction is committed, the changes made by the transaction are permanent
- `START TRANSACTION ... COMMIT;`
- Concurrency: two or more users trying to access/modify same data at the same time
- MySQL locks first transaction before second transaction can commit. When first transaction commits, others can commit. 
- problems with concurrency:              
      - lost updates             
      - dirty reads - transaction reads data that hasn't been commited yet                               
      - non-repeating (inconsistent) reads -  read once, then next query returns updated value from another commit that's diff from first read                     
      - phantom reads - data appears after query is executed        
- Transaction isolation levels:
    - READ UNCOMMITTED - can have dirty reads
    - READ COMMITTED - can have non-repeating reads
    - REPEATABLE READ (default in mysql) - can have phantom reads
    - SERIALIZABLE - solves all concurrency problems, however, it's slower. use if you want to avoid phantom reads
- Deadlock: happens when different transactions can't complete b/c each has something another transaction needs. Try to schedule jobs at diff times, at non peak hours.


## Data Types


