@sphinx @no-txn @javascript
Feature: Search comments in projects
  In order to discover what has been said about a subject
  As a Teambox user
  I want to search for keywords

  Background: 
    Given @voodoo_prince exists and is logged in
    And I am in the project called "Gold Digging"

  Scenario: Search all projects
    Given I am in the project called "Space elevator"
    When I go to the projects page
    And I follow "Gold Digging"
    And I wait for 2 seconds
    And I fill in the comment box with "I found a hunk of gold today in the mine!"
    And I press "Save"
    And I go to the projects page
    And I follow "Space elevator"
    And I wait for 2 seconds
    And I fill in the comment box with "Let's finish this space elevator before Tuesday."
    And I press "Save"
    And I go to the projects page
    
    When the search index is rebuilt
    And I fill in the search box with "the mine"
    And I submit the search
    Then I should see "1 result"
    And I should see "Gold Digging" in the results
    And I should see "I found a hunk of gold" in the results
    But I should not see "finish this space elevator" in the results

  Scenario: Search for a conversation by title
    Given there is a conversation titled "Where are the cats?" in the project "Gold Digging"
    When the search index is reindexed
    And I search for "cats"
    Then I should see "Where are the cats" in the results
    And I should see "Gold Digging" in the results

  Scenario: Search for a conversation by body
    Given there is a conversation with body "Oh my god I love cats LOL" in the project "Gold Digging"
    When the search index is reindexed
    And I search for "cats"
    Then I should see "Oh my god I love cats LOL" in the results
    And I should see "Gold Digging" in the results

  Scenario: Search for a task
    Given there is a task titled "Feed the cats" in the project "Gold Digging"
    When the search index is reindexed
    And I search for "cats"
    Then I should see "Feed the cats" in the results
    And I should see "Gold Digging" in the results

  Scenario: Search for a task list
    Given the task list called "Take care of the cats" belongs to the project called "Gold Digging"
    When the search index is reindexed
    And I search for "cats"
    Then I should see "Take care of the cats" in the results
    And I should see "Gold Digging" in the results

  Scenario: Search for a page in the title
    Given the project page "Minerals to watch for" exists in "Gold Digging"
    When the search index is reindexed
    And I search for "minerals"
    Then I should see "Minerals to watch for" in the results

  Scenario: Search for a page in the note content
    Given the project page "Minerals to watch for" exists in "Gold Digging" with the body "I have a hammer"
    When the search index is reindexed
    And I search for "hammer"
    Then I should see "Minerals to watch for" in the results

  Scenario: Search for a page in a very long note content
    Given the project page "Minerals to watch for" exists in "Gold Digging" with the body "I have a hammer" that is huge
    When the search index is reindexed
    And I search for "hammer"
    Then I should see "Minerals to watch for" in the results

  Scenario: Search for an upload in a task
    Given there is a task titled "See my lolcats" in the project "Gold Digging"
    And the task titled "See my lolcats" has a file named "lolcat1.png" attached
    When the search index is reindexed
    And I search for "lolcat1"
    Then I should see "See my lolcats" in the results

  Scenario: Search for an upload in a conversation
    Given there is a conversation titled "Invisible lolcats!!" in the project "Gold Digging"
    And the conversation titled "Invisible lolcats!!" has a file named "invisible_violin.png" attached
    When the search index is reindexed
    And I search for "invisible_violin"
    Then I should see "Invisible lolcats!!" in the results

  Scenario: Search for google doc in a task
    Given there is a task titled "Lolcats spreadsheet" in the project "Gold Digging"
    And the task titled "Lolcats spreadsheet" has a google doc named "lolcat.xls" attached
    When the search index is reindexed
    And I search for "lolcat.xls"
    Then I should see "Lolcats spreadsheet" in the results

  Scenario: Search for google doc in a conversation
    Given there is a conversation titled "List of funny animals" in the project "Gold Digging"
    And the conversation titled "List of funny animals" has a google doc named "no-moar-cats" attached
    When the search index is reindexed
    And I search for "no-moar-cats"
    Then I should see "List of funny animals" in the results

