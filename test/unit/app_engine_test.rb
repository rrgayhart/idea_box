require_relative '../helpers/unit_helper'

class AppEngineTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    setup_all
  end

  def app
    IdeaBoxApp
  end

  def test_each_idea_has_an_index_page
    post "/", {idea: {title: "exercise", description: "sign up for stick fighting classes"}}
    get '/0'
    assert last_response.ok?
    assert last_response.body =~ /exercise/
  end
  
  def test_it_moves_to_index
    get '/'
    assert last_response.ok?
    assert_equal 200, last_response.status
    assert last_response.body =~ /Existing/
  end

  def test_create_new_idea
    post "/", {idea: {title: "exercise", description: "sign up for stick fighting classes"}}
    idea = IdeaStore.all.first
    idea_title = idea.title
    assert_equal "exercise", idea_title
  end

  def test_it_creates_two_ideas_and_stores_them
    post "/", {idea: {title: "exercise", description: "sign up for stick fighting classes"}}
    post "/", {idea: {title: "write", description: "write about signing up for stick fighting classes"}}
    idea_count = IdeaStore.all.count
    assert_equal 2, idea_count
  end

  def test_it_deletes_the_correct_idea
     post "/", {idea: {title: "exercise again", description: "sign up for stick fighting classes"}}
     post "/", {idea: {title: "write again", description: "write about signing up for stick fighting classes"}}
     first_idea_title = IdeaStore.all.first.title
     delete '/0'
     second_idea_title = IdeaStore.all.first.title
     refute_equal first_idea_title, second_idea_title
  end

  def test_it_likes_an_idea
     post "/", {idea: {title: "I'm still working out", description: "sign up for stick fighting classes"}}
     post '/0/like'
     first_idea = IdeaStore.all.first
     assert_equal 1, first_idea.rank
  end
end
