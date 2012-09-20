require 'test_helper'
class PostTest < Test::Unit::TestCase

  # test "the truth" do
  #   assert true
  # end

def test_post_empty_question
  post = Post.new
  assert !post.valid?
end
end
