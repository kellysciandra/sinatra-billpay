

class User < ActiveRecord::Base
  has_many :bills
  has_many :types, through: :bills

    # has_secure_password macro works in conjunction with bcrypt
    # to give us the ability to store plain text passwords
    # in the db.
  has_secure_password
  validates_presence_of :username
end
