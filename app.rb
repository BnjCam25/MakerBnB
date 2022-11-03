require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/property_repository'
require_relative './lib/database_connection'
require_relative './lib/user_repository'
require_relative './lib/date_repository'
require 'bcrypt'

DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions


# Declares a route that responds to a request with:
  #  - a GET method
  #  - the path /
  get '/' do
    repo = PropertyRepository.new
    @properties = repo.all
    @properties.sort!{|a, b| b.id <=> a.id}
    @user_id = session[:user_id]
    @name = session[:name]
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
    new_user.password = BCrypt::Password.create(params[:password])
    repo.create(new_user)
    return erb(:user_created)
  end

  get '/login' do
    return erb(:login)
  end


  post '/login' do
    repo = UserRepository.new
    users = repo.all
    result = users.select{|user| user.email == params[:email] && BCrypt::Password.new(user.password) == params[:password]}
    if result.length > 0
      @success = "Success"
      session[:user_id] = result[0].id
      session[:name] = result[0].name
    else
      @success = "Failed"
    end
    
    return erb(:logged_in)
  end

  get '/availability/:id' do
    repo = PropertyRepository.new
    @property = repo.find(params[:id])
    return erb(:availability)
  end

  post '/availability/:id' do
    repo_p = PropertyRepository.new
    @property = repo_p.find_dates_by_id(params[:id])
    
    new_date = DateEntry.new
    
    
    new_date.start_date = params[:start_date]
    new_date.end_date = params[:end_date]
    
    
    repo_d = DateRepository.new
    repo_d.create(new_date, params[:id])

    @property = repo_p.find_dates_by_id(params[:id])

    @dates = repo_d.all
    return erb(:availability_added)
  end

  get '/availability_added' do
    return erb(:availability_added)
  end

end