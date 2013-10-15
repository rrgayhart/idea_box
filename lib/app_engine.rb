require 'rubygems'
#require 'bundler/setup'
require 'sinatra/base'
require 'bundler'
Bundler.require
#require 'idea_box'
class IdeaBoxApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  not_found do
    erb :error
  end
  # set :root, '../lib/app'
  # set :method_override, true

  get '/' do
     erb :index
  end
end
