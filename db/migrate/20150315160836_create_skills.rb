class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :skill_name
      t.integer :student_id

      t.timestamps null: true
    end
  end
end
