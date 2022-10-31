{{TABLE NAME}} Model and Repository Classes Design Recipe

Copy this recipe template to design and implement Model and Repository classes for a database table.
1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: students

Columns:
id | name | cohort_name

2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE properties RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO properties (name, decription, price) VALUES ('Sandsend', 'Stunning appartment with a view of the sea front', 200);
INSERT INTO properties (name, decription, price) VALUES ('Quaint Cottage', 'Sleepy little cottage with an apple orchard', 150);


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Student
end

# Repository class
# (in lib/student_repository.rb)
class StudentRepository
end

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: properties

# Model class
# (in lib/property.rb)

class Property

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :description, :price
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.
5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: properties

# Repository class
# (in lib/property_repository.rb)

class PropertyRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, description, price FROM properties;

    # Returns an array of Property objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, description, price FROM properties WHERE id = $1;

    # Returns a single Property object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end

6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all properties

repo = PropertyRepository.new

properties = repo.all

properties.length # =>  2

properties[0].id # =>  1
properties[0].name # =>  'Sandsend'
properties[0].description # =>  'Stunning appartment with a view of the sea front'
properties[0].price # => '200'

properties[1].id # =>  2
properties[1].name # =>  'Quaint Cottage'
properties[1].description # =>  'Sleepy little cottage with an apple orchard'
properties[1].price # => '150'

# 2
# Get a single property

repo = PropertyRepository.new

property = repo.find(1)

property.id # =>  1
property.name # =>  'Sandsend'
property.description # =>  'Stunning appartment with a view of the sea front'
property.price # => '200'

# Add more examples for each method

Encode this example as a test.
7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/porperty_repository_spec.rb

def reset_properties_table
  seed_sql = File.read('spec/properties_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe PropertyRepository do
  before(:each) do 
    reset_properties_table
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.