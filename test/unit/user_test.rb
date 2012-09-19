require 'test_helper'
require 'test/unit'
require_relative '../../app/models/user'

class UserTest < Test::Unit::TestCase
  fixtures :users
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

  def testUnits
    assert true
  end

  def test_if_valid_user_created
   user = User.new
   assert !user.valid?
  end
end

