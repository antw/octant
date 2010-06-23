# encoding: utf-8

require 'octant/builders'
require 'octant/formatters'
require 'octant/item'
require 'octant/navigation'

module Octant

  ###############
  module_function
  ###############

  # Sets up a new navigation menu.
  #
  # @param [Symbol] name
  #   A name for this menu.
  # @param [Octant::Formatters::Basic] formatter
  #   A formatter to use when rendering the menu as HTML.
  # @param [Block] &blk
  #   A block for setting up the menu.
  #
  # @return [Octant::Navigation]
  #   Returns the menu instance which was set up.
  #
  def setup(name = :default, formatter = nil, &blk)
    Builders::Navigation.new(name, formatter).build(&blk).tap do |nav|
      @registry ||= {}
      @registry[nav.name] = nav
    end
  end

  # Returns menu instance identified by +name+.
  #
  # @param [Symbol] name
  #   The name of the menu to return. If no name is given, the default menu
  #   will be returned.
  #
  # @return [Kin::Nav::Menu]
  #   Returns the Menu instance identified by +name+.
  #
  # @api public
  #
  def get(name = :default)
    @registry ||= {}
    @registry[name]
  end

  # Resets the registry.
  #
  # @api public
  #
  def reset!
    @registry = {}
    nil
  end

end
