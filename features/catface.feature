Feature: Get Catface data

  Scenario: Get dashboard
    When I send a GET request to "/catface"
    Then the response status should be "200"
    And the XML response should have "//title" with the text "Catface"
    And the XML response should have "//div[@id = 'numbers']"
