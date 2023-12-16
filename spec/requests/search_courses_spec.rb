require 'rails_helper'
# for new search function feature controller testing | RAILAST206-36
RSpec.describe CoursesController, type: :controller do

    describe "POST #search" do
      let!(:course1) { FactoryBot.create(:course, CRN: "12345", Name: "Software Engineering 1") }
      let!(:course2) { FactoryBot.create(:course, CRN: "78901", Name: "Physics") }
      let!(:course3) { FactoryBot.create(:course, CRN: "11223", Name: "Software Eng") }
      # happy paths
      context "with valid CRN" do
        it "redirects to the course show page" do
          post :search, params: { crn: "12345" }
          expect(response).to redirect_to(course_path(course1))
        end
      end
  
      context "with valid course name" do
        it "renders the page with matching courses" do
          post :search, params: { course_name: "Software Engineering 1" }
          expect(response).to redirect_to(courses_path(courses: [course1.id])) 
          expect(assigns(:courses)).to include(course1)
        end
      end
  
      context "with valid course partial name" do
        it "renders the page with matching courses" do
          post :search, params: { course_name: "Software Eng" }
          expect(response).to redirect_to(courses_path(courses: [course1.id, course3.id]))
          expect(assigns(:courses)).to include(course3)
        end
      end
  
      # sad paths for new search feature
      context "with empty search criteria" do
        it "redirects to the index page with a flash alert" do
          post :search, params: { crn: "", course_name: "" }
          expect(response).to redirect_to(courses_path)
          expect(flash[:alert]).to be_present
        end
      end
  
      context "with invalid CRN and course name" do
        it "redirects to the index page with a flash alert" do
          post :search, params: { crn: "999999", course_name: "Biology" }
          expect(response).to redirect_to(courses_path)
          expect(flash[:alert]).to be_present
        end
      end
    end
  end