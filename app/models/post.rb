class Post < ActiveRecord::Base
  attr_accessible :title, :content
  belongs_to :category
  belongs_to :user
end
