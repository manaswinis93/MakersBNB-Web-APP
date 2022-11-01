require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
DatabaseConnection.connect('makersbnb_test')
#require_relative 'lib/user_repository'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  user_repos = UserRepository.new
  
  post '/register' do
    # expected params:
    # email, password
    result = user_repos.create(
      params[:email],
      params[:password]
    )
    if result.nil?
      # error, user was not registered
      # show register page (200)
      @error_msg = "This email has already been registered, would you like to <a href='/login'>login</a>?"
      return erb(:register)
    else
      # success, user was registered and result=their id
      # redirect to login (302)
      redirect "/login"
    end
  end
end
