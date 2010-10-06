module Octant
  module Formatters

    # The most basic formatter possible which outputs clean, semantic HTML
    # representing the navigation.
    class Base

      # Creates a new BasicFormatter instance.
      #
      # @param [Kin::Nav::Menu] nav
      #   An instance of a Menu to be rendered as HTML.
      # @param [Hash] options
      #   Options used to customise the formatter.
      #
      def initialize(nav, options = {})
        @nav = nav
        @guards = options.fetch(:guard, {})
        @inject = options.fetch(:inject, {})

        # Escape injected content.
        @inject.each do |item_name, contents|
          contents = Array(contents)
          contents.map! { |v| escape_xml(v) }
          @inject[item_name] = contents
        end

        location = options.fetch(:location, {})
        @current = nav.active_item(location[:controller], location[:action])
      end

      # Transforms the menu given to +initialize+ into a string containing
      # HTML.
      #
      # @return [String]
      #   HTML containing the rendered menu. A collection of list elements
      #   contained in an unordered list.
      #
      def to_html
        tag(:ul, @nav.items.map do |item|
          trasform_item_to_html(item) if item.display?(@guards)
        end.join("\n"), :id => "#{@nav.name}_navigation")
      end

      private # ==============================================================

      # Receives an individual nav item and transforms it into HTML.
      #
      # @param [Kin::Nav::Item] item
      #   The nav item to be transformed.
      #
      # @return [String]
      #   A string containing an HTML list element.
      #
      def trasform_item_to_html(item)
        label = item.label(@inject[item.name])

        html_list_item(item) do
          if item.url
            html_link(item) { label }
          else
            # Don't add an anchor element if no URL is set.
            tag :span, label, :class => 'disabled'
          end
        end
      end

      # Returns a list element, yielding to allow injection of the anchor
      # element.
      #
      # @param [Kin::Nav::Item] item
      #   The item to be transformed to HTML.
      #
      # @return [String]
      #
      def html_list_item(item)
        tag :li, yield, :id => "nav_#{item.name}",
          :title => item.title(@inject[item.name]),
          :class => @current == item ? 'active' : ''
      end

      # Returns an anchor element containing a link for the menu item.
      #
      # @param [Kin::Nav::Item] item
      #   The item to be transformed to HTML.
      #
      # @return [String]
      #
      def html_link(item)
        tag :a, yield, :href => item.url
      end

      # Creates a string for an HTML tag.
      #
      # Heavily inspired by the +tag+ helper in merb-helpers (MIT license).
      #
      # @param [Symbol] name
      #   The tag name.
      # @param [#to_s] contents
      #   String contents to be used in the element.
      # @param [Hash] attributes
      #   Optional attributes added to the element.
      # @param [Block] &block
      #   An alternative to string contents; the result of the block is
      #   used instead.
      #
      # @return [String]
      #
      def tag(name, contents = nil, attributes = {}, &block)
        if contents.is_a?(Hash)
          attributes, contents = contents, nil
        elsif contents
          contents = contents.to_s
        end

        contents = block.call if block_given?

        if attributes.empty?
          "<#{name}>#{contents}</#{name}>"
        else
          string_attributes = attributes.map do |attr_name, attr_value|
            next unless attr_value.to_s =~ /\S/ # Skip blanks.
            %(#{attr_name}="#{attr_value}")
          end.compact.join(' ')

          "<#{name} #{string_attributes}>#{contents}</#{name}>"
        end
      end

      ESCAPE_TABLE = {
        '&' => '&amp;',
        '<' => '&lt;',
        '>' => '&gt;',
        '"' => '&quot;',
        "'" => '&#039;',
      }

      # Escapes content such that it can be safely used in HTML.
      #
      # Taken from Erubis (MIT licensed).
      #
      def escape_xml(value)
        value.to_s.gsub(/[&<>"']/) { |s| ESCAPE_TABLE[s] }   # or /[&<>"']/
      end

    end # Base

  end # Formatters
end # Octant
