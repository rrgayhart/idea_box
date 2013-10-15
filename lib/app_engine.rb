require 'rubygems'
#require 'bundler/setup'
require 'sinatra/base'
require 'bundler'
Bundler.require
require "idea"


class IdeaBoxApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  not_found do
    erb :error
  end

  get '/' do
     erb :index#, locals: {ideas: something}
  end

  post '/' do
    idea = Idea.new(params['idea_title'], params['idea_description'])
    idea.save
    redirect '/'
  end

end
