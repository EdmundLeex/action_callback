require 'test_helper'

class CallbackTest < Minitest::Unit::TestCase
  def setup
    @callback_chain = Callback::Chain.new
  end

  def test_it_initializes_with_before_and_after_callback
    assert_includes @callback_chain.instance_variables, :@_before_chain
    assert_includes @callback_chain.instance_variables, :@_after_chain
  end

  def test_it_appends_callback
    @callback_chain.append(:before, :mth, :callback)
    assert_includes @callback_chain.before_chain_of(:mth), :callback
  end

  def test_it_only_appends_unique_callbacks
    @callback_chain.append(:before, :mth, :callback)
    assert @callback_chain.before_chain_of(:mth).size == 1

    @callback_chain.append(:before, :mth, :callback_2)
    assert @callback_chain.before_chain_of(:mth).size == 2
  end
end