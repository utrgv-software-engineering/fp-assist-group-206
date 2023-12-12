# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

teacher = User.create(email: "teacher@teacher.com", password: "default123", user_id:1)
student = User.create(email: "student1@student.com", password: "default123", registered_courses: [], user_id:0)
student = User.create(email: "student2@student.com", password: "default123", registered_courses: [], user_id:0)

#course1 = Course.create(CRN: "12345", Name: "Software Engineering 1", Description: "Learn about agile practices", Capacity: 35)
#course2 = Course.create(CRN: "12346", Name: "Software Engineering 2", Description: "Practice Agile", Capacity: 20)
#course3 = Course.create(CRN: "12347", Name: "Operating Systems", Description: "Learn about the inner workings of your Operating System", Capacity: 45)
#course4 = Course.create(CRN: "12348", Name: "Computer Science II", Description: "Learn different data structures in CS using C++", Capacity: 30)