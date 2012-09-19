class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.references :User
      t.references :Post
      t.references :Comment
      t.timestamps
    end
  end
end
