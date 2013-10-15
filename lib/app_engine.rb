require 'rubygems'
#require 'bundler/setup'
require 'sinatra/base'
require 'bundler'
Bundler.require
#require 'idea_box'
class IdeaBoxApp < Sinatra::Base
  # set :root, '../lib/app'
  # set :method_override, true

  get '/' do
     erb :index
  end
end
