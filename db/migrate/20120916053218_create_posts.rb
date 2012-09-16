class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :category
      t.timestamp :creation_time

      t.timestamps
    end
  end
end
