module Octant
  module Formatters

    # A formatter which uses HTML5 elements.
    class HTML5 < Base

      # Transforms the menu given to +initialize+ into a string containing
      # HTML.
      #
      # @return [String]
      #   HTML containing the rendered menu. A collection of list elements
      #   contained in a nav + menu element.
      #
      def to_html
        tag(:nav,
          tag(:menu, @nav.items.map do |item|
            trasform_item_to_html(item) if item.display?(@guards)
          end.join("\n"), :id => "#{@nav.name}_navigation", :type => "list"))
      end

    end # HTML5

  end # Formatters
end # Octant
