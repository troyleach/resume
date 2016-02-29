class CreateExperienceDetails < ActiveRecord::Migration
  def change
    create_table :experience_details do |t|
      t.text :detail
      t.integer :experience_id

      t.timestamps null: true
    end
  end
end
