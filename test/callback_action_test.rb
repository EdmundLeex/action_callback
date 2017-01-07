require 'test_helper'

class CallbackActionTest < Minitest::Test
  class Foobar
    attr_reader :foobar

    extend CallbackAction

    before_action :before, only: [:foo, :double_foo, :around_foo]
    before_action :another_before, only: [:double_foo]
    after_action  :after, only: [:bar, :double_bar, :around_foo]
    after_action  :another_after, only: [:double_bar]

    def initialize
      @foobar = ''
    end

    def before
      @foobar << 'before_'
    end

    def another_before
      @foobar << 'another_before_'
    end

    def after
      @foobar << '_after'
    end

    def another_after
      @foobar << '_another_after'
    end

    def foo
      @foobar << 'foo'
    end

    def double_foo
      @foobar << 'double_foo'
    end

    def bar
      @foobar << 'bar'
    end

    def double_bar
      @foobar << 'double_bar'
    end

    def around_foo
      @foobar << 'around_foo'
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::CallbackAction::VERSION
  end

  def test_it_adds_before_callback
    foobar = Foobar.new
    foobar.foo

    assert foobar.foobar == 'before_foo'
  end

  def test_it_adds_multiple_before_callback
    foobar = Foobar.new
    foobar.double_foo

    assert foobar.foobar == 'before_another_before_double_foo'
  end

  def test_it_adds_after_callback
    foobar = Foobar.new
    foobar.bar
    assert foobar.foobar == 'bar_after'
  end

  def test_it_adds_multiple_after_callback
    foobar = Foobar.new
    foobar.double_bar
    assert foobar.foobar == 'double_bar_after_another_after'
  end

  def test_it_invokes_callback_everytime
    foobar = Foobar.new
    foobar.foo
    assert foobar.foobar == 'before_foo'
    foobar.foo
    assert foobar.foobar == 'before_foobefore_foo'
  end

  def test_it_calls_both_before_and_after_callback
    foobar = Foobar.new
    foobar.around_foo
    assert foobar.foobar == 'before_around_foo_after'
  end
end
