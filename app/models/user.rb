require 'bcrypt'

class User < ActiveRecord::Base
  has_many :urls
  validates :name, :email, :password_hash, :presence => true
  validates :email, :uniqueness => true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # def self.create(name, email, password)
  #   @user = User.new(:name => name, :email => email)
  #   @user.password=(password)
  #   @user.save!
  # end


end

