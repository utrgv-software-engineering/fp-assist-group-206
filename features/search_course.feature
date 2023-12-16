Feature: Course Search Functionality

  As a signed in user, So I can browse from a huge selection of courses, I want to be able to search for a course by CRN or name

  Background: 
    Given there are several courses available
    And there are users including at least one student
    And I log in as a student

  Scenario: Search for a course by CRN
    And I go to the homepage
    When I enter a CRN into the search field 
    And I click the "Search" button
    Then I should see courses with that CRN in the search results

  Scenario: Search for a course by name
    And I go to the homepage
    When I enter a course name into the search field 
    And I click the "Search" button
    Then I should see courses with that name in the search results

    Scenario: Searching with an invalid CRN
     Given there are several courses available
     When I enter an invalid CRN into the search field
     And I click the "Search" button
     Then I should see a message indicating that no course was found for CRN

    Scenario: Searching with an invalid course name
     Given there are several courses available
     When I enter an invalid course name into the search field
     And I click the "Search" button
     Then I should see a message indicating that no courses were found for course name