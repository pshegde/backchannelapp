class GenerateAdmin < ActiveRecord::Migration
  def up
    User.create :first_name => "admin" ,
                :last_name => "admin" ,:email => "admin@ncsu.edu", :username => "admin", :password => "ea10d7f57391963e1d4a48ebeac8ddc6c4022da4",:salt => "491124840.15898209315975098" ,:admin => true
  end

  def down
    User.delete_all
  end
end
