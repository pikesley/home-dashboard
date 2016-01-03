@vcr
Feature: Get JSON

  Background:
    Given I send and accept JSON

  Scenario: Get JSON for a repo
    When I send a GET request to "snake"
    Then the response status should be "200"
    And the JSON response should have "$[0]name" with the text "feeds"

  Scenario: Get JSON for a dataset
    When I send a GET request to "catface/flea-treatment"
    Then the response status should be "200"
    And the JSON response should have "$.title" with the text "Flea Treatment"
    And the JSON response should have "$.data[0].Date" with the text "2015-12-03"
