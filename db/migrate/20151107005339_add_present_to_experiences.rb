class AddPresentToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :present, :boolean, :default => false
  end
end
