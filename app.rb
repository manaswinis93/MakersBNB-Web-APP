
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
  def set_session_for_testing
    session[:current_user_id] = "1"
  end

  # config
  configure :development do
    register Sinatra::Reloader
  end

  # classes
  user_repos = UserRepository.new
  space_repos = SpaceRepository.new
  booking_repos = BookingRepository.new

  # get routes
  get '/' do
    #set_session_for_testing()
    # example of session access
    @current_user = session[:current_user_id]
    # erb
    redirect "/spaces"
  end

  get '/spaces' do
    #set_session_for_testing()
    # list spaces for a certain date
    date_param = params[:selected_date]
    @all_spaces = []
    if(date_param.nil? == false)
      @selected_date = date_param.split("-").reverse.join("/")
      @all_spaces = space_repos.all_available(@selected_date)
    end
    return erb(:spaces)
  end

  get '/register' do
    #set_session_for_testing()
    # erb
    return erb(:register)
  end

  get '/list_space' do
    #set_session_for_testing()
    return erb(:list_space)
  end
  
  
  # post routes
  post '/list_space' do
    #set_session_for_testing()

    result = space_repos.create(
      params[:name], params[:description], params[:price], session[:current_user_id]
    )  

    if (result.nil?)
      return "That Listing already exists. Please try again."
    end

    return erb(:space_added)

  end
  post '/book' do
    #set_session_for_testing()
    #
    result = booking_repos.create(
      session[:current_user_id] , params[:space_id], params[:selected_date], 'Requested'
    )
    if(result.nil?)
      return "That booking already exists. Please try again."
    end
    
    return erb(:book)
    #Work to do :letting the user choose the date 
  end

  post '/register' do
    #set_session_for_testing()
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

  post '/login' do
    # authenticate the user
    # expecting two parameters, which are email and password (both plain text)
    # if the auth response is successful (registered user enters correct email and password -not false), set the session
    # with the user ID returned
    # redirect to front page
    auth = user_repos.authenticate(
      params[:email],
      params[:password]
    )
    if(auth == false)
      # incorrect password or user doesn't exist
      @login_error = "Incorrect email or password."
      # TODO: login.erb
      return erb(:login)
    else
      # correct
      session[:current_user_id] = auth
      session[:guest_or_host] = params[:guest_or_host]
      redirect "/"
    end
  end

end
