class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.string :name
      t.string :due_date
      t.string :payment
      t.integer :user_id
      t.integer :type_id
    end
  end
end
