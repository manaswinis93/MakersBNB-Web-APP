# Bookings Model and Repository Classes Design Recipe

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
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE bookings RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO bookings (user_id, space_id, date, status) VALUES (1, 1, '01/11/2022', 'Approved');
INSERT INTO bookings (user_id, space_id, date, status) VALUES (2, 1, '01/11/2022', 'Declined');
INSERT INTO bookings (user_id, space_id, date, status) VALUES (2, 1, '01/11/2022', 'Declined');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/booking.rb)
class Booking
end

# Repository class
# (in lib/booking_repository.rb)
class BookingRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/booking.rb)

class Booking

  # Replace the attributes by your own columns.
  attr_accessor :id, :space_id, :user_id, :date, :status
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/booking_repository.rb)

class BookingRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # user_id,space_id,date,status
  def create(user_id,space_id,date,status)
    

  end

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
# Create a booking

repo = BookingRepository.new
booking = Booking.new

booking.date = '02/11/2022'


# example from Haydn and Manaswini's POST route
repo.create(1,2,"02/11/2022","Requested")

def all()
  # returns all
end

def create(user_id,space_id,date,status)
  # SQL insert query
  # 
  booking = Booking.new
  booking.date=date
  booking.space_id=space_id
  booking.user_id=user_id
  booking.id=id
  # and other attrs
  return booking
end



# Encode this example as a test.




## 7. Reload the SQL seeds before each test run

# Running the SQL code present in the seed file will empty the table and re-insert the seed data.

# This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/booking_repository_spec.rb

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
  context "create a booking" do
    it "should add a booking with the passed arguments" do
      
      repo = BookingRepository.new
      booking_result = repo.create(1,2,"02/11/2022","Requested")

      # check that the method has returned a booking instance
      expect(booking_result.date).to eq('02/11/2022')
      expect(booking_result.status).to eq('Requested')
    end
    it "should reject a booking that already exists" do
      
      repo = BookingRepository.new
      booking_result_first = repo.create(1,2,"02/11/2022","Requested")
      # attempting to create a duplicate booking
      booking_result_second = repo.create(1,2,"02/11/2022","Requested")

      # should return nil, as no booking could be created
      # due to it already existing
      expect(booking_result_second).to eq(nil)
    end
  end

## 8. Test-drive and implement the Repository class behaviour

# _After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

