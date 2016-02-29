class AddStreetAddressToStudents < ActiveRecord::Migration
  def change
    add_column :students, :address, :string
    add_column :students, :city, :string
    add_column :students, :state, :string
    add_column :students, :appt_number, :string
  end
end