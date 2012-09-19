class CreatePost < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.references :User
      t.references :Category
      t.timestamps
    end

  end

  def down
    drop_table :posts
  end
end
