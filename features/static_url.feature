Feature: Static, string-based URLs
  In order to allow navigation from one page to another
  Then it should be possible to link items to arbitrary, static URLs

  Scenario: When no URL is set
    Given a navigation like
      """
      nav.add(:home, "Home")

      """
    Then the home item should not have a link element

  Scenario: When a URL is set
    Given a navigation like
      """
      nav.add(:home, "Home") do |item|
        item.url "/"
      end

      """
    Then the home item should have a link element
      And the home anchor should link to "/"
