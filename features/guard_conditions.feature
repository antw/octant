Feature: Guard conditions
  In order ensure unauthorised users cannot view protected areas
  Then it should be possible to hide some tabs from some users

  Background:
    Given a navigation like
      """
      nav.add(:public, "Public")

      nav.add(:private, "Private") do |item|
        item.guard :staff
      end

      nav.add(:top_secret, "Top Secret") do |item|
        item.guard :admin
      end

      """

  Scenario: When no guard conditions are given
    Then I should see the public item
      And I should not see the private item
      And I should not see the top_secret item

  Scenario: When the staff guard condition is enabled
    When the "staff" guard is enabled
    Then I should see the public item
      And I should see the private item
      And I should not see the top_secret item

  Scenario: When the admin guard condition is enabled
    When the "admin" guard is enabled
    Then I should see the public item
      And I should not see the private item
      And I should see the top_secret item

  Scenario: When both the staff and admin guard conditions are enabled
    When the "staff" guard is enabled
      And the "admin" guard is enabled
    Then I should see the public item
      And I should see the private item
      And I should see the top_secret item
