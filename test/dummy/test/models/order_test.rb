require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "it doesn't run if there is error" do
    order = Order.new

    order.ship
    assert_not_equal(order.status, 'shipped')
    assert order.errors.full_messages.include?('not paid')
  end

  test "it doesn't ruin the ActiveRecord validation chain" do
    order = Order.new
    order.status = 'created'

    assert !order.save
    assert order.errors.present?

    order.number = 'O123456'

    assert order.save
    assert !order.errors.present?
  end

  test "it doesn't ruin the ActiveRecord custom validation" do
    order = Order.new
    order.number = 'O123456'

    assert !order.save
    assert order.errors.present?

    order.status = 'created'
    assert order.save
    assert !order.errors.present?
  end
end
