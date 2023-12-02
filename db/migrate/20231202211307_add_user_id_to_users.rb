class AddUserIdToUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
    t.string "CRN"
    t.string "Name"
    t.text "Description"

    t.timestamps
    end
  end 
end
