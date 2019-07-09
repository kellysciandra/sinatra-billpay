class Bill < ActiveRecord::Base
    belongs_to :type
    belongs_to :user

    validates_presence_of :name
    validates_presence_of :due_date
    validates_presence_of :payment
end 
