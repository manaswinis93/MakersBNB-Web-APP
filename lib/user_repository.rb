require_relative './user'
class UserRepository
    def find(email)
      sql = 'SELECT id, email, password FROM users WHERE email = $1;'
      sql_params = [email]
      result_set = DatabaseConnection.exec_params(sql, sql_params) 
      record = result_set.first
      if record != nil
      user = User.new
      user.id = result_set[0]['id']
      user.email = result_set[0]['email']
      user.password = result_set[0]['password']
      return user
      else
        return nil
      end
    end
  
    def create(email, password)
        if find(email) == nil 
            sql = 'INSERT INTO users (email, password) VALUES ($1, $2);'
            sql_params = [email, password]
            DatabaseConnection.exec_params(sql, sql_params)
            return ''
        else 
            return nil
        end
    end

  end