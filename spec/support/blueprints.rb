# encoding: utf-8

def (Octant::Navigation).make(options = {})
  options = { :name => :name, :formatter => nil }.merge(options)
  Octant::Navigation.new(*options.values_at(:name, :formatter))
end

def (Octant::Item).make(options = {})
  options = { :name => :name, :label => 'label' }.merge(options)
  Octant::Item.new(*options.values_at(:name, :label))
end
