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
    user.first_name="prajakta"
    user.last_name="amberkar"
    user.email="pamberk@ncsu.edu"
    #user.password = "password"
    user.original_password = "password"
    assert !user.valid?
    user.errors[:username]= ["has already been taken"]
  end


  def test_authenticate
    user = User.new
    user.username = "testuser"
    user.original_password="testpassword"
    #user.password = "testpassword"
    user.first_name="abc"
    user.last_name="xyz"
    user.email="abc@ncsu.edu"
    user.save

    assert_not_nil User.authenticate("testuser","testpassword")
    assert_nil User.authenticate(user.username,"wrongpassword")

  end



end