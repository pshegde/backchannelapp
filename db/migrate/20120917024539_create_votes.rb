class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer  "numVotes",   :default => 0
      t.timestamps
    end
  end
end
