Feature: Create a course

As a teacher so I can show my students new courses available, I want to be able to create a course

Scenario: Create a course
    Given there are 3 courses and 2 users, teacher and student
    And I log in as a teacher
    And I go to the homepage
    When I click "New course"
    And fill out the form
    Then I should be able to see that course

Scenario: Create a course with name empty
    Given there are 2 course and 1 users, a teacher
    And I log in as a teacher
    And I go to the homepage
    When I click "New course"
    And I leave the course name blank
    Then I should not be able to see that course

Scenario: Create a course with description empty
    Given there are 2 course and 1 users, a teacher
    And I log in as a teacher
    And I go to the homepage
    When I click "New course"
    And I leave the course description blank
    Then I should not be able to see that courseB


Scenario: Create a course with low capacity
    Given there are 2 users, teacher and student
    And I log in as a teacher
    And I go to the homepage
    When I click "New course"
    And I fill out the form with low capacity
    Then I should not be able to create the course

