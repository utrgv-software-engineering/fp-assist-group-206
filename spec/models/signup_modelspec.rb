require 'rails_helper'

RSpec.describe User, type: :model do
  context "should not sign up", comment: "this should not see the sign up button" do
    it "does not have :registerable value and does not have content for sign up" do
      # Check if :registerable value is present
      expect(User.devise_modules).not_to include(:registerable)
  
      # Check if sign up content is not present
      expect(User.devise_modules).not_to include(:registerable_content)
        end
    end
  end