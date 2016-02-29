class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :student_id
      t.text :good_word
      t.integer :referencer_id

      t.timestamps null: true
    end
  end
end
