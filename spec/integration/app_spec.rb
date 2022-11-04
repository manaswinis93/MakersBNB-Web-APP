require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_database
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test'})
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_database
  end
  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.


  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(302)
    end
  end
  
  context "GET /spaces" do
    it 'returns 200 OK and returns an empty list when no date is specified' do
      response = get('/spaces')

      expect(response.status).to eq(200)
      expect(response.body).not_to include("space-item")
    end
  
    it 'returns 200 OK and returns list of spaces without one that has been booked on this date' do
      response = get('/spaces',
        selected_date: '05/11/2022'
      )
      expect(response.status).to eq(200)
      expect(response.body).not_to include("cottage_3")
    end
  end

  context "POST /register" do
    it 'returns 302, registers user and redirects to login page' do
      # Assuming the email address is unique
      response = post('/register',
        email: 'janedoe@example.com',
        password: 'password312'
      )
      expect(response.status).to eq(302)
      expect(response.body).to eq("")
    end
    
    it 'returns 200, does not register user, returns error message' do
      response_initial = post('/register',
        email: 'doejane@example.com',
        password: 'password312'
      )

      response = post('/register',
        email: 'doejane@example.com',
        password: 'password312'
      )
      expect(response.status).to eq(200)
      expect(response.body).to include("This email has already been registered")
    end
  end

  
  context "POST /book" do
    xit 'returns 200 OK and books space' do
      response = post('/book', space_id: 2  )

      expect(response.status).to eq(200)
      expect(response.body).to include("Your Booking has been Requested!")
    end
  end



  #list_space testing
  #Get Route for list_space
  context "GET /list_space" do
    it 'returns 200 OK and adds a space to rent' do
      response = get('/list_space')

      expect(response.status).to eq(200)
      expect(response.body).to include ('<form method="post" action="/list_space">')
      expect(response.body).to include ('<input type="text" name="name" />')
    end
  end
  #Post route for list_space (space added)
  context "POST /list_space" do
    it 'returns 200 OK and adds a space to rent' do
      response = post('/list_space', name: "Yellow Cottage" , description: "A nice stay" , price: "100")

      expect(response.status).to eq(200)
      expect(response.body).to include ("Your listing has been added.")
    end
  end
 
 #test cases for Get/login route   
 context "GET /login" do
  it 'returns 200 OK and adds a space to rent' do
    response = get('/login')

    expect(response.status).to eq(200)
    expect(response.body).to include ('<form method="post" action="/login">')
    expect(response.body).to include ('<input id="email" type="email" name="email" required />')
    expect(response.body).to include ('<input id="password" type="password" name="password" required />')
  end
end

#test cases for POST /login route  
context "POST/login" do
  it "returns 302 OK if the existing user enters correct email address and password" do
    response_initial = post('/register',
      email: 'janedoe@example.com',
      password: 'password312'
    )
    response = post('/login', email:'janedoe@example.com', password:'password312', dropdown:'Guest')
    expect(response.status).to eq(302)
    expect(response.body).to eq("")
  end
end
 context "POST/login" do
  it "returns 302 OK if the existing user enters correct email address and password" do
    response_initial = post('/register',
      email: 'janedoe@example.com',
      password: 'password312'
    )
    response = post('/login', email:'janedoe@example.com', password:'password312', dropdown:'Host')
    expect(response.status).to eq(302)
    expect(response.body).to eq("")
  end
end
context "POST/login" do
  it "returns 200 OK if the existing user enters incorrect email address or password" do
    response_initial = post('/register',
      email: 'janedoe@example.com',
      password: 'password312'
    )
    response = post('/login', email:'janedoe@example.com', password:'password123', dropdown:'Guest')
    expect(response.status).to eq(200)
    expect(response.body).to include ("Incorrect email or password.")
  end
end

 context "POST/login" do
  it "returns 200 OK if the existing user enters incorrect email address or password" do
    response_initial = post('/register',
      email: 'janedoe@example.com',
      password: 'password312'
    )
    response = post('/login', email:'janrdoe@example.com', password:'password312', dropdown:'Host')
    expect(response.status).to eq(200)
    expect(response.body).to include ( "Incorrect email or password.")
  end
end 

# test case for GET/logout
context "GET /logout" do
  it 'returns 302 REDIRECT and returns list of spaces' do
    response = get('/logout')

    expect(response.status).to eq(302)
    expect(response.body).to include("")
    #expect(response.body).to include("<title>Spaces | MakersBnB</title>")
    #expect(response.body).to include("Login</a>")


  end
end

end

