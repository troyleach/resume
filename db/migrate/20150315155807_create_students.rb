class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :linkedin
      t.string :twitter
      t.string :blog
      t.string :online_resume
      t.string :github
      t.string :photo
      t.text :short_bio

      t.timestamps null: true
    end
  end
end
