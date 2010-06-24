# Octant

**Source**
:  [http://github.com/antw/octant](http://github.com/antw/octant)

**Author**
:  Anthony Williams

**Copyright**
:  2009-2010

**License**
:  MIT License

## SYNOPSIS

Octant is a library for aiding the creation of navigation elements. For
example:

    <ul>
      <li id="nav_home" class="active">
        <a href="/" title="Return to the home page">Home</a>
      </li>
      <li id="nav_products">
        <a href="/products" title="Products">Products</a>
      </li>
      <li id="nav_contact">
        <a href="/contact" title="Contact Us">Contact Us</a>
      </li>
    </ul>

This sort of UI pattern can be seen on just about every website, and Octant
aims to simplify the creation of these elements. The above HTML fragment would
be generated by the following definition:

    Octant.setup(:default) do |menu|
      menu.add(:home, 'Home') do |item|
        item.url       '/'
        item.active_on '*/*'
        item.title     'Home page'
      end

      menu.add(:products, 'Products') do |item|
        item.url       '/products'
        item.active_on 'products/*'
      end

      menu.add(:contact, 'Contact Us') do |item|
        item.url       '/contact'
        item.active_on 'contact/new'
      end
    end

This creates a very basic menu with three items. A "Contact Us" item which
will have the "active" CSS class applied on the 'new' action of the 'contact'
controller, a "Products" item active on any action belonging to the 'products'
controller, and a "Home" item which will be active on any other
controller/action pair.

### Dynamic content

You might sometimes need to add extra content to an item from a controller or
action; this can be done with the "inject" option.

    Octant.setup(:stuff) do |menu|
      menu.add(:comments, 'Comments (%d)') do |item|
        item.url  '/comments'
        item.title 'Comments'
      end

      menu.add(:profile, '%s (%d)') do |item|
        item.url   '/you'
        item.title 'Your profile'
      end
    end

    # Display the navigation.
    display_navigation :stuff, :inject => {
      :comments => 6, :profile => ["antw", 1]
    }

The `inject` option expects a hash -- with each key matching an item in the
menu into which you wish to add content, and a value which is provided to
`String#%`.

    <ul>
      <li id="nav_comments" title="Comments">
        <a href="/">Comments (6)</a>
      </li>
      <li id="nav_you" title="Your profile">
        <a href="/you">antw (1)</a>
      </li>
    </ul>

Ruby 1.9 users can take advantage of named `String#%` parameters:

    Octant.setup(:stuff) do |menu|
      menu.add(:profile, '%(name) (%(message_count))') do |item|
        item.url '/you'
      end
    end

    # Display the navigation.
    display_navigation :stuff, :inject => {
      :profile => { :name => "antw", :message_count => 1 }
    }

### Hiding items from certain users ("guards")

For when you need to hide an item from users (such as items which you only
want to show to administrators), Octant provides the `guard` option.

    Octant.setup(:has_guards) do |menu|
      menu.add(:home, 'Home') do |item|
        item.url   '/'
      end

      menu.add(:settings, 'Settings') do |item|
        item.url   '/settings'
        item.guard :admin
      end
    end

    # Display the navigation.
    display_navigation :guarded, :guards => { :admin => session.user.admin? }

The above example creates a navigation menu with two items; the `settings`
item will only be shown to users for whom `session.user.admin?` evaluates to
true. Multiple items can share the same guard (i.e. a menu could have several
items which use the `admin` guard condition).

    display_navigation :stuff, :guards => { :admin => true }

    <ul>
      <li id="nav_home">
        <a href="/" title="Home">Home</a>
      </li>
      <li id="nav_settings" title="Settings">
        <a href="/settings">Settings</a>
      </li>
    </ul>

... while ...

    display_navigation :stuff, :guards => { :admin => false }

    <ul>
      <li id="nav_home" title="Home">
        <a href="/">Home</a>
      </li>
    </ul>

## CONTRIBUTING

* Fork the project, taking care not to get any in your eyes.

* Make your feature addition or bug fix.

* Add tests for it.

* Commit, but do not mess with the Rakefile, VERSION, or history. If you want
  to have your own version, that is fine, but bump version in a commit by
  itself so that I can ignore it when I pull.

* Send me a pull request. Bonus points for topic branches. But we all know
  everything is made up and the points don't matter... right?

## COPYRIGHT

Montage &copy; 2009-2010 by [Anthony Williams](mailto:hi@antw.me). Licensed under the MIT license. Please see the LICENSE file for more information.
