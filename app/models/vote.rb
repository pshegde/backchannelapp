class Vote < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :Post_id
  belongs_to :user
  belongs_to :post

  default_scope :order => "updated_at DESC"
end
