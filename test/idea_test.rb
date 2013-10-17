gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'idea_box'

ENV['RACK_ENV'] = 'test'

class IdeaTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    IdeaStore.environment = 'test_engine'
    IdeaStore.destroy_all
    assert_equal 0, IdeaStore.all.count
  end

  def test_idea_class_exists
    idea = Idea.new
    assert_kind_of Idea, idea
  end

  def test_idea_accepts_title_description_and_rank
    idea = Idea.new({"title" => "walk", "description" => "at least one mile per day", "rank" => 1})
    assert_equal "walk", idea.title
    assert_equal "at least one mile per day", idea.description
    assert_equal 1, idea.rank
  end

end
