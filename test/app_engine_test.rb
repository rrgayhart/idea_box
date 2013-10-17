#require File.expand_path('.../idea_box/lib/app.rb', __FILE__)
#require_relative "../lib/app_engine.rb"
#require_relative '..lib/idea_box/idea.rb'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'app_engine'

ENV['RACK_ENV'] = 'test'

class AppEngineTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    IdeaStore.environment = 'test'
    IdeaStore.destroy_all
    assert_equal 0, IdeaStore.all.count
  end

  def app
    IdeaBoxApp
  end
  
  def test_it_moves_to_index
    get '/'
    assert last_response.ok?
    assert_equal 200, last_response.status
  end

  def test_create_new_idea
    post "/", {idea: {title: "exercise", description: "sign up for stick fighting classes"}}
 
    idea = IdeaStore.all.first
    assert_equal "exercise", idea.title
    assert_equal "sign up for stick fighting classes", idea.description
  end
end
