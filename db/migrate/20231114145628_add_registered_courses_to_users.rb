class AddRegisteredCoursesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :registered_courses, :string
  end
end
