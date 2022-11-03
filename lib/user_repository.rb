
require_relative './user'
#add gem BCRYPT to handle password encryption
require 'bcrypt'

class UserRepository
  include BCrypt


#Find method returns user record matching the email passed
#Find Method returns nil if no user record exists for the email passed  
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
          hash_password = BCrypt::Password.create(password)
          sql_params = [email, hash_password]
          DatabaseConnection.exec_params(sql, sql_params)
          return ''
      else 
          return nil
      end
  end

  def authenticate(email,password)

    # SQL query check if the email exists/registered
    # check the encrypted password against the password string that has been
    # input by the user
    # if the account doesn't exist or the password is incorrect it will return
    # false

    query = find(email)
    if(query.nil?)
      # account does not exist
      return false
    else
      # account exists
      user_info = query
      pw_dec = BCrypt::Password.new(user_info.password)
      if(pw_dec==password)
        # password is correct
        return user_info.id
      else
        # password is incorrect
        return false
      end
    end

  end

end