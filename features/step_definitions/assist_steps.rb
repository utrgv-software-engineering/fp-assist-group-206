Given('there are 3 courses and 2 users, teacher and student') do
    @course1 = create(:course)
    @course2 = create(:course)
    @course3 = create(:course) 
    @teacher = create(:user)
    @student = create(:user)
end

Given('there are 2 users, teacher and student') do 
    @teacher = create(:user)
    @student = create(:user)
  end

Given('I log in as a teacher') do
    visit new_user_session_path
    fill_in "user_email", with: @teacher.email
    fill_in "user_password", with: @teacher.password
    click_on "Log in"
end

Given('I log in as a student') do
    visit new_user_session_path
    fill_in "user_email", with: @student.email
    fill_in "user_password", with: @student.password
    click_on "Log in"
end

Given('I go to the homepage') do
    visit root_path
end

When('I click {string}') do |string|
    click_on string
end

When('fill out the form') do
    fill_in "course_CRN", with: "12345"
    fill_in "course_Name", with: "Test Course"
    fill_in "course_Description", with: "Description"
    fill_in "course_Capacity", with: "21"
    click_on "Create Course"
end

Then('I should be able to see that course') do
    expect(page).to have_content("CRN: 12345")
    expect(page).to have_content("Name: Test Course")
    expect(page).to have_content("Description: Description")
    expect(page).to have_content("Capacity: 21")
end

Then('I should see {string}') do |string|
    expect(page).to have_content(string)
end

When('I click {string} link on the first course') do |string|
    first(:link, string).click
end

When('I click {string} button on the first course') do |string|
    first(:button, string).click
end

Then('I should see the course in my list of registered courses') do
    visit registered_courses_path(@student.id)
    expect(page).to have_content(@course1.CRN)
end

Given('I go to the first course') do
    visit course_path(@course1)
end
  
When('I update the description') do
    fill_in "course_Description", with: "This is the updated description"
    click_on "Update Course"
end

Then('I should see all courses') do
    @courses = Course.all
    @courses.each do |c|
        expect(page).to have_content(c.CRN)
    end
end

Then('I should see that course') do
    expect(page).to have_content(@course1.CRN)
end

When('I fill out the form with low capacity') do
    fill_in "course_CRN", with: "12345"
    fill_in "course_Name", with: "Test Course"
    fill_in "course_Description", with: "Description"
    fill_in "course_Capacity", with: "19"
    click_on "Create Course"
  end
  
  Then('I should not be able to create the course') do
    expect(page).to have_content("Course capacity must be at least 20")
  end