class Post < ActiveRecord::Base
  attr_accessible :title, :content , :Category_id, :num_votes, :updated_at
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many :votes
  has_one :category
  default_scope :order => "updated_at DESC"
  validates_presence_of :title, :content, :Category_id

  def self.destroyLinked(post)
    post.destroy
  end
end
