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

  def test_manage_ideas
    visit '/'
    fill_in 'idea[title]', :with => 'eat'
    fill_in 'idea[description]', :with => 'chocolate chip cookies'
    click_button 'Save'
    assert page.has_content?("chocolate chip cookies"), "Idea is not on page"
    #confirms that you can save an idea

    visit '/0'
    assert page.has_content?("chocolate")
    assert page.has_content?("Edit")
    assert page.has_content?("IdeaBox")
    click_button "+"
    assert page.has_content?("Number")
    #tests that liking a page stays on the index page
  end

end
