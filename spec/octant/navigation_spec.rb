# encoding: utf-8
require 'spec_helper'

describe 'Navigation' do

  # ----
  # name

  describe 'name' do
    it 'should be a symbol' do
      Octant::Navigation.make(:name => :test).name.should == :test
    end

    it 'should typecast the argument to a symbol' do
      Octant::Navigation.make(:name => 'test').name.should == :test
    end
  end

  # -----
  # items

  describe 'items' do
    it 'should be an array' do
      Octant::Navigation.make.items.should be_an(Array)
    end
  end

end
