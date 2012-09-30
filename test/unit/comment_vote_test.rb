require 'test_helper'

class CommentVotesTest < Test::Unit::TestCase

  # test "the truth" do
  #   assert true
  # end

  def test_comment_vote_create
    cost = CommentVote.new
    assert cost.valid?
  end
end