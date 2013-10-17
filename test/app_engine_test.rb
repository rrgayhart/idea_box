#require File.expand_path('.../idea_box/lib/app.rb', __FILE__)
#require_relative "../lib/app_engine.rb"
#require_relative '..lib/idea_box/idea.rb'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'app_engine'
require 'idea_box'

ENV['RACK_ENV'] = 'test'

class AppEngineTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    IdeaStore.environment = 'test_engine'
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
    assert last_response.body =~ /Welcome/
  end

  def test_it_moves_to_edit
    post "/", {idea: {title: "exercise", description: "sign up for stick fighting classes"}}
    get '/0/edit'
    assert last_response.ok?
    assert_equal 200, last_response.status
    assert last_response.body =~ /Edit your Idea:/
    assert last_response.body =~ /exercise/
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
