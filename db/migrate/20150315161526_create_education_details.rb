class CreateEducationDetails < ActiveRecord::Migration
  def change
    create_table :education_details do |t|
      t.text :detail
      t.integer :education_id

      t.timestamps null: true
    end
  end
end
