require 'test_helper'

class ActionCallbackTest < ActiveSupport::TestCase
  test "it extends ActiveRecord::Base" do
    assert_respond_to Order, :before_action
  end

  test "it doesn't run if there is error" do
    order = Order.new

    order.ship
    assert_not_equal(order.status, 'shipped')
  end
end
