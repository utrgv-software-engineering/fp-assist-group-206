FactoryBot.define do
  factory :course do
    sequence(:CRN) { |n| format('%05d', n) } # Ensure CRN is 5 characters long with leading zeros
    sequence(:Name) {|n| "Course #{n}" }
    Description { "Course description" }
    Capacity { 20 }
  end
end
