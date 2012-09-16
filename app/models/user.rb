class User < ActiveRecord::Base
  attr_accessible :password, :username
  validates_length_of :username, :within => 4..10
  validates_presence_of :password, :username

 # attr_accessor :password, :username


  def self.authenticate(username, password)
    puts "username:" + username
    puts "password:" + password
    debugger
    u=find(:first, :conditions=>["username = ?", username])
    puts u.username
    puts u.password
    return nil if u.nil?
    return u if password == u.password  #User.encrypt(pass, u.salt)==u.hashed_password
    nil
  end

end
