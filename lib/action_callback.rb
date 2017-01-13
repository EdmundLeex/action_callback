require_relative "./action_callback/version"
require_relative "./action_callback/define_callback"
require_relative "./action_callback/callback"
require_relative "./action_callback/define_validation"
require_relative "./action_callback/validation"

module ActionCallback
  include Callback
  extend self

  def ActionCallback.extended(mod)
    initialize_callback_chain(mod)

    [:before, :after].each do |callback|
      define_callback(callback)
      alias_method :"#{callback}_filter", :"#{callback}_action"
    end

    initialize_validation_chain(mod)
    define_validation
  end
end

if defined?(Rails)
  base_model = Rails.version >= '5.0' ? ApplicationRecord : ActiveRecord::Base
  base_model.extend(ActionCallback)
end