# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
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
      expect(response.body).to include("MakersBnB by priceless")
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
      expect(response.body).to include("MakersBnB by priceless")
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
        expect(response.body).to include('<input type="submit" value="create property">')
    end
  end

  context "POST create property" do
    it "returns 200 OK" do
      response = post(
        "\list_property",
        name: "London Bridge",
        description: "A very nice bridge",
        price: "1000")

      expect(response.status).to eq (200)
      expect(response.body).to include("MakersBnB by priceless")
      expect(response.body).to include("London Bridge</a> Price per night: £1000")
      expect(response.body).to include('<a href="/property/3">')

    end
  end
end