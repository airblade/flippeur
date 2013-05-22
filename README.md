# Flippeur

Flippeur is a simple feature flipper for Rails.  Features are setup in a Rails initializer and you can use any logic you like to determine whether or not a feature is available to a user.

Features are not stored in a database and there's no web UI for toggling them.

## Installation

Add this line to your application's Gemfile:

    gem 'flippeur'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flippeur

## Usage

The basic idea is that a feature is, or isn't, available to a user of your webapp.  So the logic determining whether or not a feature is available acts on a user.

In the view and the controller layers, the user is obtained automatically by calling the controller's `current_person` method (currently and regrettably hardcoded).  In the model layer you need to pass an appropriate user instance explicitly.

As an aside, the model layer doesn't feel optimal and I'm open to ideas.

First, setup your features in a Rails initializer.

```ruby
Flippeur.setup do

  feature :something_fancy do |user|
    user.is_fancy?
  end

  feature :something_else do |user|
    user.name =~ /bob/i
  end

end
```

Give each feature a name and a block.  The block should return truthy if the feature is available to the user, and falsey otherwise.

N.B. to return early from the block, use `next retvalue` instead of `return retvalue`.  For example:

```ruby
feature :add_widget do |user|
  next false unless user.company.pays_lots_of_money?
  user.admin? || user.my_friend?
end
```

Second, use the helpers to determine whether or not features are available to your current user.

### View

Use the `feature?(name)` helper with or without a block.

Without a block it acts as a simple conditional.  For example:

```erb
<% if feature? :something_fancy %>
  <p>Here is something fancy.</p>
<% else %>
  <p>You could have something fancy if you upgraded...</p>
<% end %>
```

If you pass a block it will only be called if the feature is available.  For example:

```erb
<% feature? :something_fancy do %>
  <p>Here is something fancy.</p>
<% end %>
```

### Controller

Exactly the same as the view.  For example:

```ruby
def create
  if feature? :something_fancy
    # the usual stuff
  else
    redirect_to :index, notice: 'You need to upgrade to create something fancy.'
  end
end
```

### Model

Here you also need to pass a user instance to the helper.  For example:

```ruby
class Project < ActiveRecord::Base
  belongs_to :account
  def do_something_fancy
    if feature? :something_fancy, account.users.first
      # something fancy
    end
  end
end
```

This is suboptimal and should be revisited...


## See Also

* [Flipper](https://github.com/jnunemaker/flipper)
* [Flip](https://github.com/pda/flip)
* [Rollout](https://github.com/jamesgolick/rollout)

