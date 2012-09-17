require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessible   :username, :first_name, :last_name, :email, :password
  has_many :posts
  has_many :comments
  has_many :votes

#  validates_length_of :username, :within => 4..10
  validates_presence_of :password, :username ,:first_name, :last_name, :email
 # attr_protected :id, :salt
#  attr_accessor :password    #, :username
  def password
    @password
  end



  def self.authenticate(username, password)
    puts "username:" + username
    puts "password:" + password
    u=find(:first, :conditions=>["username = ?", username])

    return nil if u.nil?

    puts u.username
    puts u.password
    return u if password == u.password#User.encrypt(password, u.salt)==u.password
    nil
  end

  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  def password=(pass)
    @password=pass
    #self.salt = User.random_string(10) if !self.salt?
    #password = @password #User.encrypt(@password, self.salt)
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end
end
