class Course < ApplicationRecord
    validate :capacity_maximum
    validate :capacity_minimum
    validate :blank_name
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
    # For issue RAILAST206-23
    def capacity_minimum
        if self.Capacity != nil
            if self.Capacity < 20
                errors.add(:Capacity, "Course capacity must be at least 20")
            end
        end
    end

    # For issue RAILAST206-26 | Bug fix: blank_name function was not validated
    def blank_name

        if self.Name == nil || self.Name == ""
            errors.add(:Name, " can't be blank")
        end

        if self.Description == nil || self.Description == ""
            errors.add(:Description, " can't be blank")
        end
    end
    # For issue RAILAST206-24
    def validating_max_registration_cap
        if self.Capacity == 0
            errors.add(:Name, "cannot be registered, course is full.")
        end
    end
end
