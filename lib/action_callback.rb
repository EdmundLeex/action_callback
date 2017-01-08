require "action_callback/version"
require "action_callback/define_callback"
require "action_callback/callback"

module ActionCallback
  include Callback
  extend self

  def ActionCallback.extended(mod)
    initialize_callback_chain(mod)

    [:before, :after].each do |callback|
      define_callback(callback)
      alias_method :"#{callback}_filter", :"#{callback}_action"
    end
  end
end

if defined?(Rails)
  base_model = Rails.version >= '5.0' ? ApplicationRecord : ActiveRecord::Base
  base_model.extend(ActionCallback)
end