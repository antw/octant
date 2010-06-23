# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec/spec_helper')

# We only use Webrat's nice tag matchers.
require 'nokogiri'
require 'webrat/core/matchers'

class OctantWorld
  include Webrat::Matchers

  # Sets up the :test navigation instance using the given +code+ string.
  def setup_nav(code)
    Octant.setup(:test) do |nav|
      eval(code)
    end
  end

  # Renders the test navigation.
  def navigation
    @rendered_nav ||= Octant::Formatters::Base.new(
      Octant.get(:test)).to_html
  end
end

World do
  OctantWorld.new
end
