class AddSubjectToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :subject, :string
  end
end
