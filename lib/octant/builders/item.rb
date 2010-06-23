# encoding: utf-8

module Octant
  module Builders

    # The Item buidler is used when creating new items within a navigation.
    # Provides the block DSL used when customising an item.
    class Item

      # Contains the built Item instance.
      attr_reader :item

      # Creates a new Item builder.
      #
      # @param [Symbol] name
      #   A unique name for the Item instance.
      # @param [String] label
      #   Text which will be used on the item when rendered as HTML.
      # @param [Octant::Navigation]
      #   The menu instance to which the item belongs.
      #
      def initialize(name, label, menu)
        @item = Octant::Item.new(name, label)
        @menu = menu
      end

      # Sets a URL to be used for the item.
      #
      # @param [#to_s] A URL.
      #
      # @return [Octant::Builders::Item]
      #   Returns self.
      #
      def url(url)
        @item.url = url.to_s
        self
      end

      # Sets the (hover) title applied to the anchor element.
      #
      # @param [String] Text to be used as the title.
      #
      # @return [Octant::Builders::Item]
      #   Returns self.
      #
      def title(title)
        @item.title = title
        self
      end

      ##
      # Sets a guard condition so that the item is only displayed if the
      # guard is +true+ when the item is rendered.
      #
      # @param [Symbol] The guard condition.
      #
      # @return [Octant::Builders::Item]
      #   Returns self.
      #
      def guard(guard)
        @item.guard = guard
        self
      end

    end # Item

  end # Builders
end # Octant
