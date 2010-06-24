# encoding: utf-8

module Octant
  # Used to match a controller name and action name to an item.
  #
  # This is used to find out which item should be considered active for the
  # given controller and action.
  #
  class ItemMatcher

    # Returns the item which this matcher is associated.
    #
    # @return [Octant::Item]
    #
    attr_reader :item

    # Creates a new ItemMatcher instance.
    #
    # @param [Octant::Item] item
    #   The item to be considered active for which the given controller and
    #   action pair.
    # @param [String, #to_s] controller_name
    #   The name of the controller.
    # @param [String, #to_s] action_name
    #   The name of the action, or '*' if the item is active for all actions
    #   on the controller.
    #
    def initialize(item, controller_name, action_name)
      controller_name = controller_name.to_s
      action_name = action_name.to_s

      # Can't use match an action name with a generic controller.
      if controller_name == '*' && action_name != '*'
        # @todo spec
        raise ArgumentError, "Can't match any controller with a specific " \
          "action: #{controller_name}/#{action_name}"
      end

      @item = item
      @controller_name = controller_name

      if match = action_name.match(/^\{(.*)\}$/)
        # The action name is a glob containing multiple actions.
        @action_name = match[1].split(',')
      else
        @action_name = [action_name]
      end
    end

    # Returns if this matcher has a controller specified.
    #
    # @return [Boolean]
    #
    def controller?
      @controller_name and @controller_name != '*'
    end

    # Returns if this is matcher has an action specified.
    #
    # @return [Boolean]
    #
    def action?
      @action_name.any? and @action_name.first != '*'
    end

    # Attempts to match against the given controller.
    #
    # @param [String] current_controller
    #   The name of the current controller.
    # @param [String] current_action
    #   The name of the current action.
    #
    # @return [Boolean]
    #
    def matches?(current_controller, current_action)
      if not controller?
        true
      elsif not action?
        @controller_name == current_controller
      else
        @controller_name == current_controller &&
        @action_name.include?(current_action)
      end
    end

  end # ItemMatcher
end # Octant
