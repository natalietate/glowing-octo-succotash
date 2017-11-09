require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

# FYI: sessions are disabled by default in Sinatra
enable :sessions

# Database configuration
set :database, 'sqlite3:development.sqlite3'

# This method lets you check your session hash for an ID and return the user ID or nil
def current_user
  User.find_by_id(session[:user_id])
end

def authenticate_user
  redirect '/' if current_user.nil?
end

# Define routes below
get '/' do
  if current_user
    redirect '/todo'
  else
    erb :index
  end
end

get '/todo' do
  authenticate_user
  @user = current_user
  erb :todo
end


# Clears the session hash to log out and sends user home
get '/logout' do
  session.clear
  redirect '/'
end

post '/todo' do
  authenticate_user
  @user = current_user
  @user.lists.create(title: params[:title])
  redirect '/todo'
end

get '/todo/new' do
  authenticate_user
  @user = current_user
  erb :'lists/new'
end


get '/todo/:id' do
  authenticate_user
  @user = current_user
  @list = List.find_by_id(params[:id])
  erb :'lists/show'
end

# # Without sessions, you would use this by iteself:
# # This post call happens when user clicks submit
# post '/login' do
#   username = params[:username].downcase # username is changed to lowercase - just an arbitrary thing for funsies
#   user = User.find_or_create_by(username: username) # find the username in database or create a new user using the username params
#   redirect "/todo?user=#{username}" # send user to dashboard page that matches their username - passing params via URL
# end

# This post call uses sessions, so it's accessible on any given page
# This post call happens when user clicks submit
post '/login' do
  username = params[:username].downcase
  user = User.find_or_create_by(username: username) # find or create based on username that is passed in
  session[:user_id] = user.id
  redirect '/todo'
end
