Feature: HTML5 formatter
  In order to be down with the cool kids
  Then it should be possible to use HTML5-specific tags

  Scenario: Using the HTML5 formatter
    Given a navigation like
      """
      nav.add(:home, "Home")

      """
      And I use the HTML5 formatter
    Then the navigation should have a "nav" element
      And the navigation should have a "menu" element
      And I should see the home item
