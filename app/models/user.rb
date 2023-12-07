class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  serialize :registered_courses, coder: JSON

  after_initialize do |r|
    r.registered_courses = [] if r.registered_courses == nil
  end
end
