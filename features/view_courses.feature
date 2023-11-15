Feature: View courses

As a user so I can see what courses I can register to, I want to be able to browse courses available.

Scenario: Viewing all courses
    Given there are 3 courses and 2 users, teacher and student
    And I log in as a student
    When I go to the homepage
    Then I should see all courses

Scenario: View one course
    Given there are 3 courses and 2 users, teacher and student
    And I log in as a student
    And I go to the homepage
    When I click "Show this course" link on the first course
    Then I should see that course