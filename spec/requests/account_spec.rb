require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  let(:student) { create(:user) }
  let(:teacher) { create(:user, id: 1) } # Assuming user with ID 1 is a teacher
  
  context "when signed in as a student" do
    before do
      sign_in student
    end
    
    it "redirects to the registered courses path" do
      get root_path
      if response.redirect?
      # Then check the final response for the expected status or path
      expect(response).to redirect_to(registered_courses_path(id: student.id))
      end
    end 
  end
  
  context "when signed in as a teacher" do
    before do
      sign_in teacher
    end
    it "should get index" do
      get root_path # Assuming this is the path that should be accessed by the user
      expect(response).to render_template(:index)
    end
  end
end