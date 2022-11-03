# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)


GET /login
POST/login (email, password, Guest/Host)


## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response 200 OK and returns list of spaces-->

All spaces
<!DOCTYPE html>
<html>
<head>
        <title>MakersBNB Login Page</title>
        <link rel="stylesheet" href="/style_new.css" >
</head>
<body>
     <div class="nav">
            <div class="nav-tab logo"><p>MakersBnB</p></div>
            <div class="nav-tab pages">
                <p><a href="/spaces">Spaces</a></p>
                <p><a href="/guest_portal">Guests Portal</a></p>
                <p><a href="/host_portal">Hosts Portal</a></p>
            </div>
            <div class="nav-tab account">
            <% if @current_user.nil? %>
                <p><a href="/login">Login</a> • <a href="/register">Register</a></p>
            <% else %>
                <p>You are logged in.</p>
            <% end %>
            </div>
        </div>
        <div class="wrapper">
            <h1>Enter your Login credentials</h1>
            <p style="color:red"> <%= @login_error%> </p>

          <form method="post" action="/login">
            <p>
              <label> Email Address</label> 
              <input type="text" name="email" required />
            </p>
            <p>
              <label> Password: </label> 
              <input type="text" name="password" required />
            </p>
            <p>
                <div class ="dropdown">
                  <button class="dropbtn">Dropdown</button>
                    <div class="dropdown-content">
                      <a href="#">Guest</a>
                      <a href="#">Host</a>
                    </div>
                </div>
            </p>
            <p>
              <input type="submit" value="submit" />
            </p>
          </form>
        </div>
</body>
</html>

```

## 3. Write Examples

_Replace these with your own design._

```
# Request:
GET /login
# Expected response:
Response for 200 OK

```


## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/app_spec.rb
require "spec_helper"
describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }

#test cases for Get/login route   
   context "GET /login" do
    it 'returns 200 OK and adds a space to rent' do
      response = get('/login')

      expect(response.status).to eq(200)
      expect(response.body).to include ('<form method="get" action="/login">')
      expect(response.body).to include ('<input type="text" name="email" required />')
      expect(response.body).to include ('<input type="text" name="password" required />')
    end
  end

#test cases for POST /login route  
  context "POST/login" do
    it "returns 302 OK if the existing user enters correct email address and password" do
      response = post('/login', email:'janedoe@example.com', password:'password312', dropdown:'Guest')
      expect(response.status).to eq(200)
      expect(response.body).to eq("")
    end
  end
   context "POST/login" do
    it "returns 302 OK if the existing user enters correct email address and password" do
      response = post('/login', email:'janedoe@example.com', password:'password312', dropdown:'Host')
      expect(response.status).to eq(200)
      expect(response.body).to eq("")
    end
  end
  context "POST/login" do
    it "returns 200 OK if the existing user enters incorrect email address or password" do
      response = post('/login', email:'janedoe@example.com', password:'password123', dropdown:'Guest')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Incorrect email or password.")
    end
  end
  
   context "POST/login" do
    it "returns 200 OK if the existing user enters incorrect email address or password" do
      response = post('/login', email:'janrdoe@example.com', password:'password312', dropdown:'Host')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Incorrect email or password.")
    end
  end

end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---