class Post < ActiveRecord::Base
  attr_accessible :category, :content, :creation_time, :title
end
