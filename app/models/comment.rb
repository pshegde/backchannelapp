class Comment < ActiveRecord::Base
  attr_accessible :content ,:Post_id ,:num_votes
  belongs_to :post
  belongs_to :user
end
