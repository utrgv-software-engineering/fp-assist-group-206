class Course < ApplicationRecord
    validates_presence_of :CRN, uniqueness: true, length: { is: 5}
    validate :capacity_maximum
    validate :capacity_minimum
    validate :validating_max_registration_cap
    validates :CRN, presence: true, uniqueness: true, length: {is: 5}

    # custom validator
    def capacity_maximum
        #if it is not null, if it was null then we can't compare it to zero
        if self.Capacity != nil
            if self.Capacity > 50
                errors.add(:Capacity, "can't be greater than 50")
            end
        end
    end
    def capacity_minimum
        if self.Capacity != nil
            if self.Capacity < 20
                errors.add(:Capacity, "Course capacity must be at least 20")
            end
        end
    end

    #validates :CRN, presence: true, uniqueness: true, length: { is: 5 }

    def blank_name

        if self.course_Name == nil 
            errors.add(:course_Name, " can't be blank")
        end

        if self.course_Description == nil 
            errors.add(:course_Description, " can't be blank")
        end
    end

    def validating_max_registration_cap
        if self.Capacity == 0
            errors.add(:Name, "cannot be registered, course is full.")
        end
    end
end
