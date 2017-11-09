require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

# Database configuration
set :database, "sqlite3:development.sqlite3"

# Define routes below
get '/' do
  erb :index
end

get '/todo' do
  erb :todo
end

post '/login' do
  username = params[:username].downcase # username is changed to lowercase - just an arbitrary thing for funsies
  user = User.find_or_create_by(username: username) # find the username in database or create a new user using the username params
  redirect "/todo?user=#{username}" # send user to dashboard page that matches their username - passing params via URL
end
