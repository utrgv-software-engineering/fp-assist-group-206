class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :CRN
      t.string :Name
      t.text :Description
      t.integer :Capacity, default: 20

      t.timestamps
    end
  end
end
