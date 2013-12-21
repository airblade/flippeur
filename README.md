# Flippeur

Flippeur is a simple feature flipper.  Features are setup with a simple Ruby DSL where you specify whether a feature is available to a user.

If you're using Rails you can pop your feature definition file in an initializer.

Features are not stored in a database and there's no web UI for toggling them.

## Installation

Add this line to your application's Gemfile:

    gem 'flippeur'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flippeur

## Usage

The basic idea is that a feature is, or isn't, available to an actor (e.g. user or account) of your webapp.

In the view and the controller layers, the user is obtained automatically by sending your configured actor method to the controller.  If you don't configure an actor method, it defaults to `:current_person`.  In the model layer you need to pass an appropriate actor instance explicitly.

First, setup your features.  With Rails this would go in `config/initializers/flippeur.rb`.

```ruby
Flippeur.setup do

  actor :current_user

  feature :something_fancy do |user|
    user.is_fancy?
  end

  feature :something_else do |user|
    user.name =~ /bob/i
  end

end
```

Give each feature a name and a block.  The block should return a truthy value if the feature is available to the actor and a falsey value otherwise.

N.B. to return early from the block, use `next retvalue` instead of `return retvalue`.  For example:

```ruby
feature :add_widget do |user|
  next false unless user.company.pays_lots_of_money?
  user.admin? || user.my_friend?
end
```

Second, use the helpers to determine whether or not features are available to your current actor.

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

Here you also need to pass an actor instance to the helper.  For example:

```ruby
Flippeur.setup do
  actor :account
  feature :something_fancy do |account|
    account.id == 42
  end
end

class Project < ActiveRecord::Base
  belongs_to :account
  def do_something_fancy
    if feature? :something_fancy, account
      # something fancy
    end
  end
end
```


## See Also

* [Flipper](https://github.com/jnunemaker/flipper)
* [Flip](https://github.com/pda/flip)
* [Rollout](https://github.com/jamesgolick/rollout)


## Intellectual Property

Copyright Andy Stewart, AirBlade Software.  Released under the MIT licence.

