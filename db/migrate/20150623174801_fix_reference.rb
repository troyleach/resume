class FixReference < ActiveRecord::Migration
  def change
  	change_table :references do |t|
      t.rename :referencer_id, :first_name
      t.rename :good_word, :last_name
      t.change :first_name, :string
      t.change :last_name, :string
      t.string :email
      t.string :phone_number
      t.string :company_name
    end
  end
end
