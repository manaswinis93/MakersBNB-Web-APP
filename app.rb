
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
    # get session
    @current_user = session[:current_user_id]
    
    # erb
    redirect "/spaces"
  end

  get'/login' do
    # get session
    @current_user = session[:current_user_id]
    
    # erb
    return erb(:login)
  end

  get '/logout' do
    session[:current_user_id] = nil
  
    redirect '/'
  end

  get '/spaces' do
    # get session
    @current_user = session[:current_user_id]
    
    # list spaces for a certain date
    date_param = params[:selected_date]
    @all_spaces = []
    if(date_param.nil? == false)
      @selected_date = date_param.split("-").reverse.join("/")
      @all_spaces = space_repos.all_available(@selected_date)
    end
    # erb
    return erb(:spaces)
  end

  get '/register' do
    # get session
    @current_user = session[:current_user_id]
    
    # erb
    return erb(:register)
  end

  get '/list_space' do
    # get session
    @current_user = session[:current_user_id]
    
    # erb
    return erb(:list_space)
  end

  get '/host_portal' do

    @current_user = session[:current_user_id]

    return erb(:host_portal)
  end

  get '/host_listings' do

    @current_user = session[:current_user_id]

    @listings = space_repos.listings_by_user(@current_user)

    return erb(:host_listings)
  end
  
  
  # post routes
  post '/list_space' do
    result = space_repos.create(
      params[:name], params[:description], params[:price], session[:current_user_id]
    )
    @space_added_msg = "Your listing has been added."
    if (result.nil?)
      @space_added_msg = "That Listing already exists. Please try again."
    end
    # get session
    @current_user = session[:current_user_id]
    
    # erb
    return erb(:space_added)
  end
  post '/book' do
    if session[:current_user_id].nil?
      redirect '/login'
    end  
    result = booking_repos.create(
      session[:current_user_id] , params[:space_id], params[:selected_date], 'Requested'
    )
    @booking_msg = "Your booking has been requested."
    if(result.nil?)
      @booking_msg = "That booking already exists. Please try again."
    end
    # get session
    @current_user = session[:current_user_id]
    
    # erb
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
      if session[:guest_or_host] == 'Host'
        redirect "/host_portal" 
      else
         redirect "/"
      end


    end
  end


end
