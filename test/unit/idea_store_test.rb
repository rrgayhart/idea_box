gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require_relative '../../lib/idea_box'

ENV['RACK_ENV'] = 'test'

class IdeaStoreTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    IdeaStore.environment = 'test_engine'
    IdeaStore.destroy_all
    assert_equal 0, IdeaStore.all.count
  end


end
