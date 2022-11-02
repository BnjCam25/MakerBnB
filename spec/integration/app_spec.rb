# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_tables
  seed_sql = File.read('spec/users_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
  seed_sql = File.read('spec/properties_seeds.sql')
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_tables
  end
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET to /" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to include("Welcome to MakersBnB!")
      expect(response.body).to include("Sandsend</a> Price per night: £200")
      expect(response.body).to include("Quaint Cottage</a> Price per night: £150")
      expect(response.body).to include('<a href="/property/1">')
      expect(response.body).to include('<a href="/property/2">')
    end
  end

  context "GET to /property/:id" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/property/1")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to include("MakersBnB!")
      expect(response.body).to include("Property details")
      expect(response.body).to include("Name: Sandsend")
      expect(response.body).to include("Description: Stunning appartment with a view of the sea front")
      expect(response.body).to include("Price per night: £200")
      expect(response.body).to include('<a href="/">')
    end
  end


  context "GET property input form" do
    it "returns 200 OK with the input form" do
        response = get("/list_property")

        expect(response.status).to eq (200)
        expect(response.body).to include("List Property")
        expect(response.body).to include('<form action="/list_property" method="POST">')
        expect(response.body).to include('<input type="text" name="name">')
        expect(response.body).to include('<input type="text" name="description">')
        expect(response.body).to include('<input type="text" name="price">')
        expect(response.body).to include('<input class="button" type="submit" value="create property">')
    end
  end

  context "POST create property" do
    it "returns 200 OK" do
      response = post(
        "/list_property",
        name: "London Bridge",
        description: "A very nice bridge",
        price: "1000")

      expect(response.status).to eq (200)
      expect(response.body).to include("<html> <meta http-equiv='Refresh' content='0; url= &quot/&quot '    /> </html>")
    end
  end


  context "GET to /signup" do
    it "returns 200 OK with the right content" do
      response = get("/signup")
      expect(response.status).to eq(200)
      expect(response.body).to include('<div><p>Name:</p> <input type="text" name="name"></div>')
    end
  end

  context "POST to /signup" do
    it "creates a new user" do
      response = post("/signup", name: 'Jim Halpert', email: 'jh@gmail.com', password: '10203040')
      expect(response.status).to eq(200)
      expect(response.body).to include("New user has been created")

    end
  end
end