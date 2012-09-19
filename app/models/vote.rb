class Vote < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :post

  default_scope :order => "updated_at DESC"
end
