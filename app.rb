require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/property_repository'
require_relative './lib/database_connection'
DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end


# Declares a route that responds to a request with:
  #  - a GET method
  #  - the path /
  get '/' do
    repo = PropertyRepository.new
    @properties = repo.all
    return erb(:Homepage)
  end

  get '/property/:id' do
    repo = PropertyRepository.new
    @property = repo.find(params[:id])
    return erb(:property)
  end

end