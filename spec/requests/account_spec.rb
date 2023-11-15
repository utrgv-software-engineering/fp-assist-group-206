require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  context "when signed in" do
    before do
      @user = create(:user)
      sign_in @user
    end
    
    it "should get index" do
      get registered_courses_path(@user.id)
    end
  end
end
