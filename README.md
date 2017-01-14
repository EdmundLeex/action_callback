[![Gem Version](https://badge.fury.io/rb/action_callback.svg)](https://badge.fury.io/rb/action_callback)
[![security](https://hakiri.io/github/EdmundLeex/action_callback/master.svg)](https://hakiri.io/github/EdmundLeex/action_callback/master)
[![Code Climate](https://codeclimate.com/github/EdmundLeex/action_callback/badges/gpa.svg)](https://codeclimate.com/github/EdmundLeex/action_callback)
[![Build Status](https://travis-ci.org/EdmundLeex/action_callback.svg?branch=master)](https://travis-ci.org/EdmundLeex/action_callback)

# CallbackAction

This gem gives you ability to add callbacks like `before_action` / `before_fitler` etc to your Active Record models and plain ruby classes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'callback_action'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install callback_action

## Usage

### 1. `validate`

#### In Rails

This gem adds a `before` option to the `validate` method.
Use it on any of your model's method. Simply add custom validation method just
like you usually do. 

- It runs the method if validation is good
- Otherwise, it returns false (if there is any error)

```ruby
class Car < ActiveRecord::Base
  validate :key_present, before: [:unlock_door]

  def unlock_door
    # unlock the door
  end

  private

  def key_present
    unless has_key? && valid_key?
      errors.add(:base, 'need the right key')
    end
  end
end

car = Car.new
car.unlock_door
# If has_key?
#   - do whatever the method does
#   - return whatever it returns
# If !has_key?
#   - returns false
#   - car.errors.full_messages => ['need the right key']
```

At the same time, it preserves the default `validate` logic if `before` option is
not used.

```ruby
class Car < ActiveRecord::Base
  validate :valid_vin_number
end
```

#### In Plain Ruby

This gem adds a `validate` method to classes that extend this module. You should
raise error in the validator method

- It execute the method if validation passes.
- It raises the error you specify in the validator method, and stop there.

```ruby
class Car
  extend ActionCallback
  validate :key_present, before: [:unlock_door]

  def unlock_door
    # unlock the door
  end

  private

  def key_present
    fail 'key invalid' unless valid_key?
  end
end
```

### 2. `before_action` / `after_action`

If you are using Rails, in your Active Record models:

```ruby
class Foobar < ActiveRecord::Base
  before_action :foobar, on: [:foo, :bar]
  
  def foo
    # ...
  end

  def bar
    # ...
  end

  def foobar
    # ...
  end
end
```

If you are using plain ruby:

```ruby
class Foobar
  extend ActionCallback

  before_action :foobar, on: [:foo, :bar]
  
  def foo
    # ...
  end

  def bar
    # ...
  end

  def foobar
    # ...
  end
end
```

### Available callbacks

Currently, you can use `before_action`, `after_action` to define callbacks.

#### `before_action` / `before_filter`

This will give you a before callback.

```ruby
before_action :before_callback, on: [:methods_that_will_invoke_before_callbacks]
```

#### `after_action` / `after_action`

This will give you a after callback.

```ruby
after_action :after_callback, on: [:methods_that_will_invoke_after_callbacks]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/edmundleex/callback_action. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

