require 'rails_helper'

RSpec.describe "/courses", type: :request do
  
  # happy paths
  describe "when signed in" do
    before do
      @user = create(:user)
      sign_in @user
      @course = create(:course)
    end

    it "get root" do
      get root_path
      expect(response).to be_successful
    end
  
    it "get show" do
      get course_path(@course)
      expect(response).to be_successful
    end
  
    it "get new" do
      get new_course_path
      expect(response).to be_successful
    end

    it "get edit" do
      get edit_course_path(@course)
      expect(response).to be_successful
    end

    context "create with valid parameters" do
      it "creates a new Course" do
        expect {
          post courses_url, params: { course: {CRN: "12345", Name: "Course name", Description: "Small description", Capacity:1} }
        }.to change(Course, :count).by(1)
        expect(response).to redirect_to(course_path(Course.last))
      end
    end

    context "create with invalid parameters" do
      it "does not create a new Course" do
        expect {
          post courses_path, params: { course: {CRN: nil, Name: "Course name", Description: "Small description", Capacity:1} }
        }.to change(Course, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end

    context "update with valid parameters" do
      it "redirects to the course" do
        course = Course.create(CRN: "12348", Name: "Course name", Description: "Small description", Capacity:1)
        patch course_path(course), params: { course: {CRN: "12345", Name: "Course name", Description: "Small description", Capacity:1 }}
        course.reload
        expect(response).to redirect_to(course_path(course))
      end
    end

    context "update with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        course = Course.create(CRN: "12345", Name: "Course name", Description: "Small description", Capacity:1)
        patch course_path(course), params: { course: {CRN: nil, Name: "Course name", Description: "Small description", Capacity:1} }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end

    it "destroys the requested course" do
      expect {
        delete course_path(@course)
      }.to change(Course, :count).by(-1)
      expect(response).to redirect_to(courses_path)
    end
  end

  # sad paths
  context "when not signed in" do
    it "should not get index" do
      get root_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end


# for new search function feature controller testing
RSpec.describe CoursesController, type: :controller do

  describe "POST #search" do
    let!(:course1) { FactoryBot.create(:course, CRN: "12345", Name: "Software Engineering 1") }
    let!(:course2) { FactoryBot.create(:course, CRN: "789012", Name: "Physics") }
    let!(:course3) { FactoryBot.create(:course, CRN: "12345", Name: "Software Eng") }
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