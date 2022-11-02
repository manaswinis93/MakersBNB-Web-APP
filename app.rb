
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
DatabaseConnection.connect('makersbnb_test')
require_relative 'lib/user_repository'
require_relative 'lib/space_repository'
require_relative  'lib/booking_repository'

class Application < Sinatra::Base
  # session
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  # classes
  user_repos = UserRepository.new
  space_repos = SpaceRepository.new
  book_repos = BookingRepository.new

  # get routes
  get '/' do
    # example of session access
    @current_user = session[:current_user_id]
    # erb
    redirect "/spaces"
  end

  get '/spaces' do
    @all_spaces = space_repos.all 
    return erb(:spaces)
  end

  get '/register' do
    # erb
    return erb(:register)
  end

  get '/list_space' do
    
    return erb(:list_space)
  end
  
  
  # post routes
  post '/book' do
    
    result = booking_repos.create(
      1 , params[:space_id], ('02/11/2022'), ('Requested')
    )
    
    return erb(:book)
    #Work to do :letting the user choose the date 
  end

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
