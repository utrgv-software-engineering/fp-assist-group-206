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
          post courses_url, params: { course: {CRN: "12345", Name: "Course name", Description: "Small description", Capacity:21} }
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
        course = Course.create(CRN: "12348", Name: "Course name", Description: "Small description", Capacity:20)
        patch course_path(course), params: { course: {CRN: "12345", Name: "Course name", Description: "Small description", Capacity:20 }}
        course.reload
        expect(response).to redirect_to(course_path(course))
      end
    end
    # Sad path
    context "update with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        course = Course.create(CRN: "12345", Name: "Course name", Description: "Small description", Capacity:20)
        patch course_path(course), params: { course: {CRN: nil, Name: "Course name", Description: "Small description", Capacity:20} }
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
