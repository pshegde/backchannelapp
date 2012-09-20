require 'test_helper'

class CommentVotesTest < Test::Unit::TestCase

  # test "the truth" do
  #   assert true
  # end

  def test_comment_vote_empty
    cost = CommentVotes.new
    assert !cost.valid?
  end
end