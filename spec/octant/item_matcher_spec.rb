# encoding: utf-8
require 'spec_helper'

describe 'ItemMatcher' do
  context 'When the the matcher has a controller and action' do
    let(:matcher) { Octant::ItemMatcher.new(nil, 'cont', 'act') }

    it 'should match when on "cont/act"' do
      matcher.matches?('cont', 'act').should be_true
    end

    it 'should not match when on "cont/no_match"' do
      matcher.matches?('cont', 'no_match').should be_false
    end

    it 'should not match when on "no_match/act"' do
      matcher.matches?('no_match', 'act').should be_false
    end

    it 'should not match when on "no_match/no_match"' do
      matcher.matches?('no_match', 'no_match').should be_false
    end
  end

  context 'When the matcher has a controller and multi-match action' do
    let(:matcher) { Octant::ItemMatcher.new(nil, 'cont', '{act,yes}') }

    it 'should match when on "cont/act"' do
      matcher.matches?('cont', 'act').should be_true
    end

    it 'should match when on "cont/yes"' do
      matcher.matches?('cont', 'yes').should be_true
    end

    it 'should not match when on "cont/no_match"' do
      matcher.matches?('cont', 'no_match').should be_false
    end

    it 'should not match when on "no_match/act"' do
      matcher.matches?('no_match', 'act').should be_false
    end

    it 'should not match when on "no_match/yes"' do
      matcher.matches?('no_match', 'yes').should be_false
    end

    it 'should not match when on "no_match/no_match"' do
      matcher.matches?('no_match', 'no_match').should be_false
    end
  end

  context 'When the matcher has a controller and glob action' do
    let(:matcher) { Octant::ItemMatcher.new(nil, 'cont', '*') }

    it 'should match when on "cont/act"' do
      matcher.matches?('cont', 'act').should be_true
    end

    it 'should match when on "cont/yes"' do
      matcher.matches?('cont', 'yes').should be_true
    end

    it 'should not match when on "no_match/act"' do
      matcher.matches?('no_match', 'act').should be_false
    end

    it 'should not match when on "no_match/no_match"' do
      matcher.matches?('no_match', 'no_match').should be_false
    end
  end

  context 'When the matcher has a glob controller and glob action' do
    let(:matcher) { Octant::ItemMatcher.new(nil, '*', '*') }

    it 'should match when on "cont/act"' do
      matcher.matches?('cont', 'act').should be_true
    end

    it 'should match when on "other/act"' do
      matcher.matches?('other', 'act').should be_true
    end

    it 'should match when on "other/other"' do
      matcher.matches?('other', 'other').should be_true
    end
  end

  it 'should permit symbol controller and actions' do
    matcher = Octant::ItemMatcher.new(nil, :cont, :act)
    matcher.matches?('cont', 'act').should be_true
  end

  it 'should raise an error when trying to match specific actions and a glob controller' do
    lambda {
      Octant::ItemMatcher.new(nil, '*', 'act')
    }.should raise_error(ArgumentError)
  end
end
