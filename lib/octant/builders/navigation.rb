# encoding: utf-8

module Octant
  module Builders

    # The Navigation buidler is used when creating new navigations using the
    # block DSL.
    class Navigation

      # Creates a new Navigation builder.
      #
      # @param [Symbol] name
      #   A unique name for the Menu instance.
      # @param [Octant::Formatters::Basic] formatter
      #   A formatter to use when rendering the menu as HTML.
      #
      def initialize(name, formatter = nil)
        @nav = Octant::Navigation.new(name, formatter)
        @item_builders = []
      end

      # Builds the nav menu. Yields the builder to provide a nicer DSL.
      #
      # @return [Octant::Navigation]
      # @yield  [Octant::Builders::Navigation] The builder instance.
      #
      def build
        yield self if block_given?
        @item_builders.each { |b| @nav.items << b.item }

        # Freeze the navigation before returning.
        @nav.freeze
        @nav.items.freeze
        @nav.items.each { |i| i.freeze }

        @nav
      end

      # Adds an item to the menu, returning an item builder which provides a
      # DSL for customising the item.
      #
      # @param [Symbol] name
      #   A unique name for the Item instance.
      # @param [String] label
      #   Text which will be used on the item when rendered as HTML.
      #
      # @return [Octant::Builders::Item]
      # @yield  [Octant::Builders::Item] The builder instance.
      #
      def add(name, label)
        ibuilder = Builders::Item.new(name.to_sym, label, @nav)
        @item_builders << ibuilder
        yield ibuilder if block_given?
        ibuilder
      end

    end # Navigation

  end # Builders
end # Octant
