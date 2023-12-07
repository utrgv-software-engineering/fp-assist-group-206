FactoryBot.define do
  factory :course do
    sequence(:CRN) { |n| "#{n}#{n}#{n}#{n}#{n}" }
    sequence(:Name) {|n| "Course #{n}" }
    Description { "Course description" }
    Capacity { 20 }
  end
end
