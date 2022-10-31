Single Table Design Recipe Template

Copy this recipe template to design and create a database table from a specification.
1. Extract nouns from the user stories or specification

# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a user I want a webpage to view properties. 


Nouns:

properties, name, description, price

2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.
Record 	Properties
property 	name, description, price

Name of the table (always plural): properties

Column names: name, description, price
3. Decide the column types.

Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

id: SERIAL
name: text
description: text
price: num

4. Write the SQL.

-- EXAMPLE
-- file: properties_table.sql

-- Replace the table name, columm names and types.

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price num
);

5. Create the table.

psql -h 127.0.0.1 database_name < albums_table.sql