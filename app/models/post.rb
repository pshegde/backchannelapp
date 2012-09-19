class Post < ActiveRecord::Base
  attr_accessible :title, :content , :Category_id, :num_votes
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many :votes
  #:order => "created_at"
  validates_presence_of :title, :content
  def self.destroyLinked(post)
    post.destroy
  end
end
