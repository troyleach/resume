class DeletingTheSkillsTable < ActiveRecord::Migration
  def change
    rename_table :skills, :personal_skills
  end
end
