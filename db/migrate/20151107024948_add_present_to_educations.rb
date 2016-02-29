class AddPresentToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :present, :boolean
  end
end
