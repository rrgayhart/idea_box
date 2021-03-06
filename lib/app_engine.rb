require 'rubygems'
#require 'bundler/setup'
require 'sinatra/base'
require 'slim'
require 'bundler'
Bundler.require
require_relative "idea_box"
#equire "idea_store"


class IdeaBoxApp < Sinatra::Base
  #set :root, './lib/app'
  set :public_folder, 'public'
  set :method_override, true
  set :root, 'lib/app/'

  configure :development do
    register Sinatra::Reloader
  end
  not_found do
    erb :error
  end

  get '/' do
     erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new}
  end

  get '/:id' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :idea, locals: {idea: idea}
  end

  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/id'
  end
  

end
