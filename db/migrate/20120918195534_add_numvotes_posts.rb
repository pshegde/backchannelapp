class AddNumvotesPosts < ActiveRecord::Migration
  def up
    add_column :posts, :num_votes, :integer, :default => 0
  end

  def down
  end
end
