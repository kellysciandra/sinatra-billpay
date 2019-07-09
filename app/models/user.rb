class User < ActiveRecord::Base
  has_many :bills
  has_many :types, through: :bills

  has_secure_password
  validates_presence_of :username
end
