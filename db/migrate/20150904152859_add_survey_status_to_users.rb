class AddSurveyStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :survey_status, :integer, default: 0
  end
end
