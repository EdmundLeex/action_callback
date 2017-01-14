require 'test_helper'

class ActionCallbackTest < ActiveSupport::TestCase
  test "it extends ActiveRecord::Base" do
    assert_respond_to Order, :before_action
  end
end
