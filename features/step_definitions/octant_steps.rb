# encoding: utf-8

Transform %r{(\w+) item} do |name|
  unless item = Nokogiri::HTML(navigation).css("#nav_#{name}").first
    raise "No #{name} item exists in the navigation"
  end

  item
end

Transform %r{(\w+) anchor} do |name|
  unless anchor = Transform("#{name} item").css("a").first
    raise "No anchor exists in the #{name} item"
  end

  anchor
end

# --- STEPS ------------------------------------------------------------------

Given %r{^a navigation like$} do |code|
  setup_nav(code)
end

Given %r{^the "(\w+)" guard is enabled$} do |guard|
  enable_guard(guard)
end

Given %r{^I inject "(.*)" into the (\w+) item$} do |content, item_name|
  inject_content(item_name, content)
end

Given %r{^the user is at "(\w+)/(\w+)"$} do |controller, action|
  set_location(controller, action)
end

# --- RESULTS ----------------------------------------------------------------

Then %r{^I should see the (\w+) item$} do |name|
  navigation.should have_selector("#nav_#{name}")
end

Then %r{^I should not see the (\w+) item$} do |name|
  navigation.should_not have_selector("#nav_#{name}")
end

Then %r{^the (\w+ item) contents should be "(.*)"$} do |item, contents|
  item.content.should == contents
end

Then %r{^the (\w+ item) should have a link element$} do |item|
  item.should have_selector("a")
end

Then %r{^the (\w+ item) should not have a link element$} do |item|
  item.should_not have_selector("a")
end

Then %r{^the (\w+) item should have a title of "(.+)"$} do |name, title|
  item = Transform "#{name} item"
  item.should have_selector("#nav_#{name}[title='#{title}']")
end

Then %r{^the (\w+ anchor) should link to "(.+)"$} do |anchor, url|
  anchor.should have_selector("[href='#{url}']")
end

Then %r{^the (\w+ item) should be active$} do |item|
  item.should have_selector("li[class='active']")
end

Then %r{^the (\w+ item) should be inactive$} do |item|
  item.should_not have_selector("li[class='active']")
end
