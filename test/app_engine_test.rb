#require File.expand_path('.../idea_box/lib/app.rb', __FILE__)
#require_relative "../lib/app_engine.rb"
#require_relative '..lib/idea_box/idea.rb'
require 'test/unit'
require 'rack/test'
require 'app_engine'

ENV['RACK_ENV'] = 'test'

class AppEngineTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    IdeaBoxApp
  end
  
  def test_it_moves_to_index
    get '/'
    assert last_response.ok?
    assert_equal 200, last_response.status
  end

   def test_it_creates_an_idea
     post '/'
     assert_equal 200, last_response.status
   end
end
