class Course < ApplicationRecord
    validates_presence_of :CRN
    validate :capacity_maximum

    # custom validator
    def capacity_maximum
        #if it is not null, if it was null then we can't compare it to zero
        if self.Capacity != nil
            if self.Capacity > 50
                errors.add(:Capacity, "can't be greater than 50")
            end
        end
    end

    def blank_name

        if self.course_Name == nil 
            errors.add(:course_Name, " can't be blank")
        end

        if self.course_Description == nil 
            errors.add(:course_Description, " can't be blank")
        end
    end

end
