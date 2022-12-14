# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)


POST /logout 


## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response 302 OK and returns the user to the page listing all spaces -->

Welcome to MakersBnB!




```

## 3. Write Examples

_Replace these with your own design._

```
# Request:
POST /logout
# Expected response:
Response for 302 OK
```


## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/app_spec.rb
require "spec_helper"
describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }
  context "POST /logout" do
    it 'returns 302 REDIRECT and returns list of spaces' do
      response = post('/logout')

      expect(response.status).to eq(302)
      expect(response.body).to include("<title>Spaces | MakersBnB</title>")
      expect(response.body).to include(<a href="/login">Login</a>)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---
