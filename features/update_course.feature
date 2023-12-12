Feature: Update courses

As a teacher so I can keep my courses with current information, I want to be able to update my courses

Scenario: Updating course information
    Given there are 3 courses and 2 users, teacher and student
    And I log in as a teacher
    And I go to the first course
    And the course capacity is not full
    When I click "Edit this course"
    And I update the description
    Then I should see "This is the updated description"