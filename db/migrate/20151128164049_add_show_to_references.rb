class AddShowToReferences < ActiveRecord::Migration
  def change
    add_column :references, :show, :boolean, :default => false
  end
end
