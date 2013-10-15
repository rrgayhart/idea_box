#require File.expand_path('.../idea_box/lib/app.rb', __FILE__)
require 'test/unit'
require 'rack/test'

require_relative 'app'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  def test_my_default
    get '/'
    assert last_response.ok?
    assert_equal 'Welcome to my page!', last_response.body
  end

  def test_with_params
    post '/', :name => 'Frank'
    assert_equal 'Hello Frank!', last_response.body
  end
end
