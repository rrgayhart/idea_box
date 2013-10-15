require 'sinatra'

get '/' do
  erb :index
end

get '/user' do
  "Welcome to user sign in"
end

get '/idea' do
  "Here is an id"
end

get '/ideabox' do
  "Here are all the ideas"
end
