Feature: Register to a course

As a student so I can get my degree I want to be able to register to courses

Scenario: Register to a course
    Given there are 3 courses and 2 users, teacher and student
    And I log in as a student
    And I go to the homepage
    When I click "Register course" button on the first course
    Then I should see the course in my list of registered courses