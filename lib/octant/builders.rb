# encoding: utf-8

module Octant
  # Provides the DSLs used when setting up new navigations. Builders should
  # not be used directly; instead use Octant.setup.
  module Builders ; end
end

require 'octant/builders/navigation'
require 'octant/builders/item'
