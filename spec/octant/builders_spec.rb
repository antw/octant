# encoding: utf-8
require 'spec_helper'

describe 'Building a navigation with a three, simple items' do
  before(:all) do
    @nav = Octant.setup(:test) do |nav|
      nav.add(:one, 'One')
      nav.add(:two, 'Two')
      nav.add(:six, 'Six')
    end
  end

  it 'should freeze the nav' do
    @nav.should be_frozen
  end

  it 'should freeze the nav items' do
    @nav.items.should be_frozen
  end

  it 'should have a single item' do
    @nav.items.length.should == 3
  end

  it 'should maintain the item order' do
    @nav.items.map(&:name).should == [:one, :two, :six]
  end
end
