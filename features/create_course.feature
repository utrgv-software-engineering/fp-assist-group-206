Feature: Create a course

As a teacher so I can show my students new courses available, I want to be able to create a course

Scenario: Create a course
    Given there are 3 courses and 2 users, teacher and student
    And I log in as a teacher
    And I go to the homepage
    When I click "New course"
    And fill out the form
    Then I should be able to see that course

