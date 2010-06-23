# encoding: utf-8
require 'spec_helper'

describe 'Item' do

  # ----
  # name

  describe 'name' do
    it 'should be a symbol' do
      Octant::Item.make(:name => :test).name.should == :test
    end

    it 'should typecast the argument to a symbol' do
      Octant::Item.make(:name => 'test').name.should == :test
    end
  end

  # -----
  # label

  describe 'label' do
    it 'should be a symbol' do
      Octant::Item.make(:label => 'label').label.should == 'label'
    end

    it 'should typecast the argument to a symbol' do
      Octant::Item.make(:label => :label).label.should == 'label'
    end
  end

  # ---
  # url

  describe 'url' do
    it 'should return nil when no URL is set' do
      Octant::Item.make.url.should be_nil
    end

    it 'should return the title when a title is set' do
      item = Octant::Item.make
      item.url = '/'
      item.url.should == '/'
    end
  end

  # -----
  # title

  describe 'title' do
    it 'should return the label when no title is set' do
      item = Octant::Item.make
      item.title.should == item.label
    end

    it 'should return the title when a title is set' do
      item = Octant::Item.make
      item.title = 'title'
      item.title.should == 'title'
    end
  end

end
