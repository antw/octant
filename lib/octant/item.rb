# encoding: utf-8

module Octant
  # Represents a single item in a navigation menu.
  class Item

    attr_reader   :name
    attr_accessor :resource, :guard, :url
    attr_writer   :title

    # Creates a new item instance.
    #
    # @param [Symbol, #to_sym]  name   A unique name for the item.
    # @param [String, #to_s]    label  The text label for the item.
    #
    def initialize(name, label)
      @name  = name.to_sym
      @label = label.to_s
      @guard = nil
    end

    # Two items are equal if they have the same name.
    #
    # @return [Boolean]
    #
    def ==(other)
      @name == other.name
    end

    # Returns the item label.
    #
    # @param [String, Array, Hash] inject
    #   An optional array containing (escaped) strings for injection. Ruby 1.9
    #   users can take advantage of named String#% parameters by supplying
    #   a hash.
    #
    # @return [String]
    #
    def label(inject = nil)
      inject ? @label % inject : @label
    end

    # Returns the item title (hover tooltip). If no title is set, the label
    # will be used intead.
    #
    # # @param [String, Array, Hash] inject
    #   An optional array containing (escaped) strings for injection. Ruby 1.9
    #   users can take advantage of named String#% parameters by supplying
    #   a hash. This is only used in the event that no explicit title is set.
    #
    # @return [String]
    #
    def title(inject = nil)
      @title or label(inject)
    end

    # Returns if this item can be displayed.
    #
    # @param [Array] Permitted guard conditions.
    #
    # @return [String]
    #
    def display?(guards = {})
      @guard.nil? or (guards and guards[@guard])
    end

  end # Item
end # Octant
