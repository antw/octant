Feature: Active items
  In order allow users to quickly determine which page they're one
  Then it should be possible to highlight an item as being active

  Scenario: When an item is active on a specific controller and action
    Given a navigation like
      """
      nav.add(:messages, "Messages") do |item|
        item.active_on "messages/index"
      end

      nav.add(:calendar, "Calendar") do |item|
        item.active_on "calendar/index"
      end

      """
    When the user is at "messages/index"
    Then the messages item should be active
      And the calendar item should be inactive

  Scenario Outline: When an item is active on a specific controller and action
    Given a navigation like
      """
      nav.add(:messages, "Messages") do |item|
        item.active_on "messages/{index,show}"
      end

      nav.add(:calendar, "Calendar") do |item|
        item.active_on "calendar/"
      end

      """
    When the user is at "messages/<action>"
    Then the messages item should be <state>
      And the calendar item should be inactive

    Examples:
      | action  | state    |
      | index   | active   |
      | show    | active   |
      | destroy | inactive |
