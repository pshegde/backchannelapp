class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :Post
      t.references :User
      t.timestamps
    end
  end
end
