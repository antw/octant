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

# --- RESULTS ----------------------------------------------------------------

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
