class Post < ActiveRecord::Base
  attr_accessible :title, :content , :Category_id
  belongs_to :category
  belongs_to :user
  #:order => "created_at"

  def self.destroyLinked(post)
    post.destroy
  end
end
