# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative '../../app'


def reset_properties_table
  seed_sql = File.read('spec/users_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end


describe Application do
  before(:each) do 
    reset_properties_table
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
      expect(response.body).to include("MakersBnB")

      expect(response.body).to include("Property details")
      expect(response.body).to include("Name: Sandsend")
      expect(response.body).to include("Description: Stunning appartment with a view of the sea front")
      expect(response.body).to include("Price per night: £200")
      expect(response.body).to include("Owner is 1")
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
        price: "1000",
        user_id: "2")

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


  context "GET login form" do
    it "returns 200 OK with the input form" do
        response = get("/login")

        expect(response.status).to eq (200)
        expect(response.body).to include("User Login")
        expect(response.body).to include('<form action="/login" method="POST">')
        expect(response.body).to include('<input type="text" name="email">')
        expect(response.body).to include('<input type="text" name="password">')
        expect(response.body).to include('<input class="button" type="submit" value="Login">')
    end
  end

  context "POST login form" do
    it "returns 200 OK and redirects to homepage" do
      response = post("/login", email: 'bd@gmail.com', password: '12345678')
      expect(response.status).to eq(200)
      expect(response.body).to include('Success')

      response = post("/login", email: 'b@gmail.com', password: '12345678')
      expect(response.status).to eq(200)
      expect(response.body).to include('Fail')

      response = post("/login", email: 'bd@gmail.com', password: '1234567')
      expect(response.status).to eq(200)
      expect(response.body).to include('Fail')
      

  context "GET to /availability/1" do
    it "returns 200 OK with the right content" do
      response = get('/availability/1')
      expect(response.status).to eq (200)
      expect(response.body).to include('<h3>List a new property dates to MakersBnB!</h3>')

    end
  end

  context "POST to /availability/1" do
    it "Creates new date" do
      response = post("/availability/1", start_date: '2022/03/10', end_date: '2022/03/15')
      expect(response.status).to eq (200)
      expect(response.body).to include('2022-06-20')
      expect(response.body).to include('2022-06-25')
      expect(response.body).to include('2022-06-05')
      expect(response.body).to include('2022-06-15')
      expect(response.body).to include('2022-03-10')
      expect(response.body).to include('2022-03-15')
      expect(response.body).not_to include('2022-04-20')
      expect(response.body).not_to include('2022-04-25')

    end
  end
end