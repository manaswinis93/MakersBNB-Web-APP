# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)


POST /register
body parameters: email, password (encrypted)

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response when the email is not found in table: 302 OK -->

Goes to login page (/login)
```

<!-- EXAMPLE -->
<!-- Response when the email is found in table: 200 OK -->
This email has already been registered, would you like to login?
(consider GET method for this)

```html

```

## 3. Write Examples

_Replace these with your own design._

```
# Request:
POST /register
# Expected response:
Response for 302 OK
```
```
# Request:
POST /register
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
  context "POST /register" do
    it 'returns 302, registers user and redirects to login page' do
      # Assuming the email address is unique
      response = post('/register',
        email: 'johndoe@example.com',
        password: 'password312'
      )
      expect(response.status).to eq(302)
      expect(response.body).to eq("")
    end
    it 'returns 200, does not register user, returns error message' do
      response_initial = post('/register',
        email: 'johndoe@example.com',
        password: 'password312'
      )

      response = post('/register',
        email: 'johndoe@example.com',
        password: 'password312'
      )
      expect(response.status).to eq(200)
      expect(response.body).to include("This email has already been registered")
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---
