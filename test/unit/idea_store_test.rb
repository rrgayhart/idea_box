
require_relative '../helpers/unit_helper'

class IdeaStoreTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    setup_all
  end

  def test_idea_store_class_exists
    idea = IdeaStore.new
    assert_kind_of IdeaStore, idea
  end

  def test_it_saves_and_finds_an_idea_to_the_ideastore
    idea = Idea.new({"title" => "run", "description" => "at least one mile per day", "rank" => 1})
    assert_equal 0, IdeaStore.all.count
    idea.save
    assert_equal 1, IdeaStore.all.count
    idea = IdeaStore.find(0)
    assert_equal "run", idea.title
  end


  def test_it_saves_and_finds_multiple_ideas
    idea1 = Idea.new({"title" => "run", "description" => "at least one mile per day", "rank" => 1})
    idea2 = Idea.new({"title" => "walk", "description" => "at least one half mile per day", "rank" => 1})
    idea3 = Idea.new({"title" => "meander", "description" => "at least three miles per day", "rank" => 1})
    assert_equal 0, IdeaStore.all.count
    idea1.save
    idea2.save
    idea3.save
    assert_equal 3, IdeaStore.all.count
    idea = IdeaStore.find(2)
    assert_equal "meander", idea.title
  end
end
