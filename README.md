[![Build Status](https://travis-ci.org/EdmundLeex/action_callback.svg?branch=master)](https://travis-ci.org/EdmundLeex/action_callback)

# CallbackAction

This gem gives you ability to add callbacks like `before_action` / `before_fitler` etc to your class.

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

If you are using Rails, you can save the `extend ActionCallback` line in active record models
(but you will still need that when you are defining a plain ruby class):

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/callback_action. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

