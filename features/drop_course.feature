Feature: Drop courses

As a student so I can avoid registering for the wrong class, I want to be able to drop courses

Scenario: Dropping a course
    Given there are 3 courses and 2 users, teacher and student
    And I log in as a student
    And I go to the homepage
    When I click "Register course" button on the first course
    And I click "Drop course" button on the first course
    Then I should see "Course was successfully dropped"