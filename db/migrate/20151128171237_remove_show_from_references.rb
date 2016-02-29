class RemoveShowFromReferences < ActiveRecord::Migration
  def change
    remove_column :references, :show, :boolean
  end
end
