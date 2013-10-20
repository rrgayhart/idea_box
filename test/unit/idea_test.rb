require_relative '../helpers/unit_helper'

class IdeaTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    setup_all
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

  def test_it_increases_rank_with_like_function
    idea = Idea.new({"title" => "silly walk", "description" => "at least one mile per day"})
    assert_equal 0, idea.rank
    idea.like!
    assert_equal 1, idea.rank
  end

  def test_ideas_can_be_sorted_by_rank
    diet = Idea.new("title" => "diet", "description" => "cabbage soup")
    exercise = Idea.new("title" => "exercise", "description" => "long distance running")
    drink = Idea.new("title" => "drink", "description" => "carrot smoothy")

    exercise.like!
    exercise.like!
    drink.like!

    ideas = [diet, exercise, drink]

    assert_equal [exercise, drink, diet], ideas.sort
  end

end
