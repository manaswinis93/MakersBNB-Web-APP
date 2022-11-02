# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)


GET /list_space


## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response 200 OK and returns list of spaces-->

All spaces

<form method="post" action="/space">
  <h1>List a space</h1>
  <input type="text" name="name" />
  <br>
  <input type="text" name="description" />
  <br>
  <input type="text" name="price" />
  <br>
  <input type="submit" value="List space" />
</form>

```

## 3. Write Examples

_Replace these with your own design._

```
# Request:
GET /list_space
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
  context "GET /list_space" do
    it 'returns 200 OK and adds a space to rent' do
      response = get('/list_spaces', name: "Yellow Cottage" , description: "A nice stay" , price: "100" )

      expect(response.status).to eq(200)
      expect(response.body).to include ("Yellow Cottage")
      expect(response.body).to include ("A nice stay")
      expect(response.body).to include ("100")
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---