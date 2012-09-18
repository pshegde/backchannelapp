class AddNumvotesComments < ActiveRecord::Migration
  def up
    add_column :comments, :num_votes, :integer, :default => 0
  end

  def down
  end
end
