require 'rails_helper'

RSpec.describe Course, type: :model do
  before do
    @user = create(:user)
  end

  it "should accept a course with valid data" do
    course = Course.new(CRN: "12345", Name: "Course name", Description: "Small description", Capacity:20)
    expect(course).to be_valid
  end

  it "should accept a course with a valid capacity" do
    course = Course.new(CRN: "12345", Name: "Course name", Description: "Small description", Capacity:51)
    expect(course).not_to be_valid
  end
end
