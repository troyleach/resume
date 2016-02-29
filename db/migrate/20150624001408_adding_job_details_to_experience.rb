class AddingJobDetailsToExperience < ActiveRecord::Migration
  def change
  	change_table :experiences do |t|
      t.text :job_details
  	end
  end
end
