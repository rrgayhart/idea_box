require 'sinatra'
require 'idea_box'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'
  
  get '/' do
    erb :index
  end

end
