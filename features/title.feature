Feature: Item titles
  In order to allow users to be enjoy the most accessible experience possible
  Then is should be possible to set a hover title for each item

  Scenario: With no title set
    Given a navigation like
      """
      nav.add(:home, "Home")

      """
    Then the home item should have a title of "Home"

  Scenario: With a title set
    Given a navigation like
      """
      nav.add(:home, "Home") do |item|
        item.title "A title"
      end

      """
    Then the home item should have a title of "A title"
