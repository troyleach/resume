class AddingJobTitleToStudent < ActiveRecord::Migration
  def change
  	add_column :students, :job_title, :string
  	rename_column :experiences, :job_details, :job_description
  end
end
