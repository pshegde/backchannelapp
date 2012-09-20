require 'test_helper'
require 'test/unit'
require_relative '../../app/models/user'
class UserTest < Test::Unit::TestCase
  #fixtures :users
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

  def  test_presence_of_username
    user = User.new
    assert !user.valid?
  end

  def  test_uniqueness_of_username
    user = User.new
    user.username = User.find_by_username(:one)
    #user.username = "efg"
    user.password = "password"

    #user.id = (users(:pshegde).id + 1)
    assert !user.valid?
    user.errors[:username]= ["has already been taken"]
  end


end