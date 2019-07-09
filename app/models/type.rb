class Type < ActiveRecord::Base
  has_many :bills
  has_many :users, through: :bills

  validates_presence_of :category
end
