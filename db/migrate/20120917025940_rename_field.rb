class RenameField < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :isadmin, :admin
    end
  end

  def down
  end
end
