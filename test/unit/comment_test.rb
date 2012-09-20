require 'test_helper'
class CommentTest < Test::Unit::TestCase

  # test "the truth" do
  #   assert true
  # end

  def test_comment_empty
    cost = Comment.new
    assert !cost.valid?
  end
end
