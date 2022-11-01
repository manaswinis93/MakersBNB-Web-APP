# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{spaces}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE spaces RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO spaces (name, description, price, user_id) VALUES ('cottage_4', 'some description', '200', 1);
INSERT INTO spaces (name, description, price, user_id) VALUES ('cottage_2', 'some random description', '200', 1);
INSERT INTO spaces (name, description, price, user_id) VALUES ('cottage_3', 'nice description', '150' 2);
INSERT INTO spaces (name, description, price, user_id) VALUES ('cottage_1', 'Good description', '250' 2);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.



## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: spaces

# Model class
# (in lib/space.rb)

class Space

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :description, :price, :user_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: spaces

# Repository class
# (in lib/spaces_repository.rb)

class SpaceRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # sql= 'SELECT id, name, description, price, user_id FROM spaces;'

    # Returns an array of spaces objects.
  end

  def find(id)
    # Executes the SQL query:
    # 'SELECT id, name, description, price, host_id FROM spaces where id = $1;

    # Returns a single space object.
  end

  # Add more methods below for each operation you'd like to implement.

   def create(space)
    # Executes the SQL query:
    # INSERT INTO spaces name, description, price, host_id VALUES ($1, $2, $3, $4);

    # Returns a single space object.

   end
  # To be decided --- nice to have for user to update and delete spaces if he wants to 
  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all spaces

repo = SpaceRepository.new

spaces = repo.all
spaces.length # =>  4
spaces[0].id # =>  1
spaces[0].name # =>  'cottage_4'
spaces[0].description # =>  'some dsecription'
spaces[0].price # =>  200
spaces[0].user_id # =>  1


#2 
#return a single space

repo = SpaceRepository.new

space = repo.find(1)

space.id # =>  1
space.name # =>  'cottage_4'
space.description # =>  'some dsecription'
space.price # =>  200
space.user_id # =>  1

# 3
# Inserts a single space record into spaces table

repo = SpaceRepository.new

space = Space.new
space.name = 'cottage_5'
space.description =  'Just dsecription'
space.price = 300
space.user_id =  3
repo.create(space)
spaces = repo.all
spaces.length # =>  5
spaces[-1].id # =>  5
spaces[-1].name # =>  'cottage_5'
spaces[-1].description # =>  'Just dsecription'
spaces[-1].price # =>  300
spaces[-1].user_id # =>  3 #will be a session variable



```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/space_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
