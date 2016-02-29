class AddShowReferencesToStudents < ActiveRecord::Migration
  def change
    add_column :students, :show_references, :boolean, :default => false
  end
end
