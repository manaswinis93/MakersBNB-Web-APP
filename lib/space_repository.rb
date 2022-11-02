require_relative './space'

class SpaceRepository

    def all
      # Executes the SQL query:
      sql= 'SELECT id, name, description, price, user_id FROM spaces;'
      result_set = DatabaseConnection.exec_params(sql, [])
      spaces = []
      result_set.each do |record|
        space = Space.new
        space.id = record['id'].to_i
        space.name = record['name']
        space.description = record['description']
        space.price = record['price']
        space.user_id = record['user_id'].to_i
        spaces << space
      end
      return spaces
    end

    def is_available(space_id,date_string)
      # checks if a space is available on this date (dd/mm/yyyy)
      sql = "SELECT spaces.id, spaces.name, spaces.description, spaces.price, spaces.user_id, bookings.date
      FROM spaces
      LEFT JOIN bookings ON spaces.id=bookings.space_id
      AND spaces.id=$1;"
      record = DatabaseConnection.exec_params(sql, [space_id])[0]
      # returns boolean
      return (record['date'] != date_string)
    end

    def all_available(date_string)
      # selects spaces that are available on this date (dd/mm/yyyy)
      # Executes the SQL query:
      sql = "SELECT spaces.id, spaces.name, spaces.description, spaces.price, spaces.user_id, bookings.date
      FROM spaces
      LEFT JOIN bookings ON spaces.id=bookings.space_id;"
      result_set = DatabaseConnection.exec_params(sql, [])
      spaces = []
      result_set.each do |record|
        if(record['date'] != date_string)
          space = Space.new
          space.id = record['id'].to_i
          space.name = record['name']
          space.description = record['description']
          space.price = record['price']
          space.user_id = record['user_id'].to_i
          spaces << space
        end
      end
      return spaces
    end
  
    def find(id)
      # Executes the SQL query:
      sql = 'SELECT id, name, description, price, user_id FROM spaces where id = $1;'
      result_set = DatabaseConnection.exec_params(sql, [id])
      record = result_set.first
        space = Space.new
        space.id = record['id'].to_i
        space.name = record['name']
        space.description = record['description']
        space.price = record['price']
        space.user_id = record['user_id'].to_i
      return space

    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(name, description, price, user_id)
      # Executes the SQL query:
      check_sql = "SELECT * FROM spaces WHERE name = $1"
        check_results = DatabaseConnection.exec_params(check_sql, [name])
        if(check_results.ntuples < 1)

          sql = 'INSERT INTO spaces (name, description, price, user_id)  VALUES ($1, $2, $3, $4);'
          sql_params = [name, description, price, user_id]
          DatabaseConnection.exec_params(sql, sql_params)
          return " "
        else
          return nil
        end 
    end
    # To be decided --- nice to have for user to update and delete spaces if he wants to 
    # def update(student)
    # end
  
    # def delete(student)
    # end
  end