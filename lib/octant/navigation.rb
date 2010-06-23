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
    end

  end # Navigation
end # Octant
