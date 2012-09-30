require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessible   :username, :first_name, :last_name, :email, :original_password, :salt, :admin, :password
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :comment_votes, :dependent => :destroy

  default_scope :order => "updated_at DESC"
  #attr_accessor :original_password
#  validates_length_of :username, :within => 4..10
  validates_presence_of  :username ,:first_name, :last_name, :email
  validates_uniqueness_of :username
 # attr_protected :id, :salt
#  attr_accessor :password    #, :username
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  def self.authenticate(username, password)
    u=find(:first, :conditions=>["username = ?", username])
    return nil if u.nil?

    return u if u.encrypt_password(password, u.salt)==u.password
    nil
  end

  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  def encrypt_password(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def original_password=(password)
    @original_password = password
    return if password.blank?
    create_new_salt
    self.password = encrypt_password(password, self.salt)
  end

  def original_password
    @original_password
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
