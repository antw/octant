Feature: Content injection
  In order allow menu item contents to change at run-tim
  Then it should be possible to inject content into menus

  Scenario: Injecting a single value
    Given a navigation like
      """
      nav.add(:messages, "Messages (%d)")

      """
      And I inject "2" into the messages item
    Then the messages item contents should be "Messages (2)"
      And the messages item title should be "Messages (2)"

  Scenario: Injecting multiple values
    Given a navigation like
      """
      nav.add(:messages, "%s (%d)")

      """
      And I inject "Inbox" into the messages item
      And I inject "2" into the messages item
    Then the messages item contents should be "Inbox (2)"
      And the messages item title should be "Inbox (2)"

  Scenario: Injecting a single value when a title is set
    Given a navigation like
      """
      nav.add(:messages, "Messages (%d)") do |item|
        item.title "Hello!"
      end

      """
      And I inject "2" into the messages item
    Then the messages item contents should be "Messages (2)"
      And the messages item title should be "Hello!"

  Scenario: Injecting HTML-unsafe content
    Given a navigation like
      """
      nav.add(:messages, "Messages (%s)")

      """
      And I inject "<" into the messages item
    # No escaping would result in the contents being "Messages ("
    Then the messages item contents should be "Messages (<)"
      And the messages item title should be "Messages (<)"
