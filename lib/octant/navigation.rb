# encoding: utf-8

module Octant
  # Represents a navigation menu. Contains one or more items which are links
  # to other parts of the application.
  class Navigation

    # A unique identifier for the navigation instance.
    #
    # @return [Symbol]
    #
    attr_reader :name

    # The navigation items which belong to the navigation.
    #
    # @return [Array<Octant::Item>]
    #
    attr_reader :items

    # Creates a new menu instance.
    #
    # @param [Symbol, #to_sym] name
    #   A unique name for the navigation instance.
    # @param [Octant::Formatters::Basic] formatter
    #   A formatter to be used when rendering the menu.
    #
    def initialize(name, formatter = nil)
      @name = name.to_sym
      @formatter = formatter
      @items = []

      # Used to find the active item on a given page.
      @matchers = Struct.new(:best, :controller, :generic).new([], [], [])
    end

    # Adds a controller name / action name pair for matching active items.
    #
    # @param [String] name
    #   The name of an controller and action.
    # @param [Octant::Item] item
    #   A menu item.
    #
    # @return [Octant::ItemMatcher]
    #
    def add_active_match(name, item)
      name = name.split('/')
      matcher = ItemMatcher.new(item, name[0..-2].join('/'), name.last)

      if matcher.action?
        @matchers.best << matcher
      elsif matcher.controller?
        @matchers.controller << matcher
      else
        @matchers.generic << matcher
      end

      matcher
    end

    # Returns the active item based on the given controller / action.
    #
    # @param [String, #to_s] controller_name
    #   The name of the controller.
    # @param [String, #to_s] action_name
    #   The name of the action, or '*' if the item is active for all actions
    #   on the controller.
    #
    # @return [Symbol]
    #
    def active_item(controller, action)
      match = lambda { |matcher| matcher.matches?(controller, action) }

      found =
        @matchers.best.detect(&match)       ||
        @matchers.controller.detect(&match) ||
        @matchers.generic.detect(&match)

      found.item if found
    end

  end # Navigation
end # Octant
