# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec/spec_helper')

# We only use Webrat's nice tag matchers.
require 'nokogiri'
require 'webrat/core/matchers'

class OctantWorld
  include Webrat::Matchers

  def initialize(*args, &block)
    super
    @formatter_options = {}
  end

  # Enables a guard condition.
  def enable_guard(guard)
    @formatter_options[:guard] ||= {}
    @formatter_options[:guard][guard.to_sym] = true
  end

  # Adds content to be injected into a navigation item.
  def inject_content(item, contents)
    @formatter_options[:inject] ||= {}
    @formatter_options[:inject][item.to_sym] ||= []
    @formatter_options[:inject][item.to_sym] << contents
  end

  # Sets up the :test navigation instance using the given +code+ string.
  def setup_nav(code)
    Octant.setup(:test) { |nav| eval(code) }
  end

  # Sets the controller/action which should be considered active.
  def set_location(controller, action)
    @formatter_options[:location] = {
      :controller => controller.to_s,
      :action     => action.to_s
    }
  end

  # Renders the test navigation.
  def navigation
    @rendered_nav ||= Octant::Formatters::Base.new(
      Octant.get(:test), @formatter_options).to_html
  end
end

World do
  OctantWorld.new
end
