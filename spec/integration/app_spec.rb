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
    end
  end

  #context "POST to /post" do
   # xit "returns 200 OK with the right content" do
      # Send a POST request to /submit
      # with some body parameters
      # and returns a response object we can test.
      #response = post("/submit", name: "Dana", some_other_param: 12)
      #response = post("/post")

      # Assert the response status code and body.
      #expect(response.status).to eq(200)
      #expect(response.body).to eq("Hello post priceless")
    #end
  #end
end