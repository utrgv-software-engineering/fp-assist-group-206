require 'rails_helper'
# For issue RAILAST206-23
RSpec.describe Course, type: :model do
  before do
    @user = create(:user)
  end

  it "should not accept a course with valid data" do
    course = Course.new(CRN: "12345", Name: "Course name", Description: "Small description", Capacity:19)
    expect(course).not_to be_valid
  end
  it "should accept a course with valid data" do
    course = Course.new(CRN: "12345", Name: "Course name", Description: "Small description", Capacity:20)
    expect(course).to be_valid
  end

  it "should accept a course with a valid capacity" do
    course = Course.new(CRN: "12345", Name: "Course name", Description: "Small description", Capacity:50)
    expect(course).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:CRN) }
    it { should validate_uniqueness_of(:CRN) }
    it { should validate_length_of(:CRN).is_equal_to(5) }
  end

end
