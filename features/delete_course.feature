Feature: Delete course

As a teacher so I can keep the site with valid information, I want to be able to delete a course

Scenario: Delete a course
    Given there are 3 courses and 2 users, teacher and student
    And I log in as a teacher
    And I go to the homepage
    And the course capacity is empty
    When I click "Show this course" link on the first course
    And I click "Destroy this course"
    Then I should see "Course was successfully destroyed."