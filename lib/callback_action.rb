require "callback_action/version"
require "callback_action/define_callback"
require "callback_action/callback"

module CallbackAction
  extend self
  include Callback

  def CallbackAction.extended(mod)
    initialize_callback_chain(mod)

    [:before, :after].each do |callback|
      define_callback(callback)
      alias_method :"#{callback}_filter", :"#{callback}_action"
    end
  end
end
