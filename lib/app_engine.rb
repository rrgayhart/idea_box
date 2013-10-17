require 'rubygems'
#require 'bundler/setup'
require 'sinatra/base'
require 'bundler'
Bundler.require
require "idea_box"
#equire "idea_store"


class IdeaBoxApp < Sinatra::Base
  set :root, 'lib/app'
  set :method_override, true
  #set :views, '/Users/rrgayhart/sites/sinatra/idea_box/lib/app/views/'

  configure :development do
    register Sinatra::Reloader
  end
  not_found do
    erb :error
  end

  get '/' do
     erb :index, locals: {ideas: IdeaStore.all, idea: Idea.new}
  end

  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  

end
