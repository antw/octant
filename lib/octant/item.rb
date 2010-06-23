# encoding: utf-8

module Octant
  # Represents a single item in a navigation menu.
  class Item

    attr_reader   :name, :label
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

    # Returns the item title (hover tooltip). If no title is set, the label
    # will be used intead.
    #
    # @return [String]
    #
    def title
      @title or @label
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
