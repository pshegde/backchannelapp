require 'test_helper'
class CategoryTest < Test::Unit::TestCase

  # test "the truth" do
  #   assert true
  # end

  def test_category_empty
    cost = Category.new
    assert !cost.valid?
  end
end