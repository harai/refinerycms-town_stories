@town_stories
Feature: Town Stories
  In order to have town_stories on my website
  As an administrator
  I want to manage town_stories

  Background:
    Given I am a logged in refinery user
    And I have no town_stories

  @town_stories-list @list
  Scenario: Town Stories List
   Given I have town_stories titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of town_stories
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @town_stories-valid @valid
  Scenario: Create Valid Town Story
    When I go to the list of town_stories
    And I follow "Add New Town Story"
    And I fill in "Dummy" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 town_story

  @town_stories-invalid @invalid
  Scenario: Create Invalid Town Story (without dummy)
    When I go to the list of town_stories
    And I follow "Add New Town Story"
    And I press "Save"
    Then I should see "Dummy can't be blank"
    And I should have 0 town_stories

  @town_stories-edit @edit
  Scenario: Edit Existing Town Story
    Given I have town_stories titled "A dummy"
    When I go to the list of town_stories
    And I follow "Edit this town_story" within ".actions"
    Then I fill in "Dummy" with "A different dummy"
    And I press "Save"
    Then I should see "'A different dummy' was successfully updated."
    And I should be on the list of town_stories
    And I should not see "A dummy"

  @town_stories-duplicate @duplicate
  Scenario: Create Duplicate Town Story
    Given I only have town_stories titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of town_stories
    And I follow "Add New Town Story"
    And I fill in "Dummy" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 town_stories

  @town_stories-delete @delete
  Scenario: Delete Town Story
    Given I only have town_stories titled UniqueTitleOne
    When I go to the list of town_stories
    And I follow "Remove this town story forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 town_stories
 