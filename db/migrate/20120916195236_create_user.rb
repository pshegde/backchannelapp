class CreateUser < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password
      t.string :salt
      t.boolean :is_admin?
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end