class CreateProfessionalSkills < ActiveRecord::Migration
  def change
    create_table :professional_skills do |t|
      t.string :skill_name
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
