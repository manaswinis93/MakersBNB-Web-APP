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

  context "GET /spaces" do
    it 'returns 200 OK and returns list of spaces' do
      response = get('/spaces')

      expect(response.status).to eq(200)
      expect(response.body).to include("Space1")
    end
  end
end
