@vcr
Feature: Get JSON

  Background:
    Given I send and accept JSON

  Scenario: Get JSON for a dataset
    When I send a GET request to "catface/flea-treatment"
    Then the response status should be "200"
    And the JSON response should have "$.title" with the text "Flea Treatment"
