require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/property_repository'
require_relative './lib/database_connection'
require_relative './lib/user_repository'

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


  get '/list_property' do
    return erb(:list_property)
  end

  post '/list_property' do
    property = Property.new
    property.name = params[:name]
    property.description = params[:description]
    property.price = params[:price]
    p property.name
    repo = PropertyRepository.new

    repo.create(property)

    @properties = repo.all

    return "<html> <meta http-equiv='Refresh' content='0; url= &quot/&quot '    /> </html>"
  end
  get '/signup' do
    return erb(:signup)
  end

  post '/signup' do
    repo = UserRepository.new
    new_user = User.new
    new_user.name = params[:name]
    new_user.email = params[:email]
    new_user.password = params[:password]
    repo.create(new_user)
    return erb(:user_created)

  end

end