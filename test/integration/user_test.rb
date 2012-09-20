#require "test/unit"
#require "test/integration_test_helper"
class User < ActionDispatch::IntegrationTest

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_fail

    # To change this template use File | Settings | File Templates.
#    fail("Not implemented")
  end

  def test_login_page
    visit "/login/new"
    fill_in "username", :with=>users(:one).uname
    fill_in "password", :with=>"password"
    click_button "Login"
    assert(current_path)=="/posts/index"

  end
end