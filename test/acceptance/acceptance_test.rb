require_relative '../helpers/acceptance_helper'

class UserAcceptanceTest < Minitest::Test
  include Capybara::DSL # gives you access to visit, etc.

  def setup
    IdeaStore.environment = 'test_engine'
    IdeaStore.destroy_all
    assert_equal 0, IdeaStore.all.count
  end

  def test_it_doesnt_blow_up
    visit '/'
    assert page.has_content?("Welcome")
  end

  # write your tests here

end
