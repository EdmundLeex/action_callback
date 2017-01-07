module CallbackAction
  ALLOWED_SCOPE = [:only].freeze

  private

  def initialize_callback_chain(mod)
    mod.instance_variable_set('@_callback_chain', Callback::Chain.new)

    mod.define_singleton_method(:_callback_chain) do
      instance_variable_get('@_callback_chain')
    end
  end

  def define_callback(callback_hook)
    define_method("#{callback_hook}_action") do |callback, method_scope|
      validate_method_scope(method_scope)

      method_scope[:only].each do |mth_name|
        @_callback_chain.append_callback(callback_hook, mth_name, callback)

        undef_method(mth_name) if method_defined?(mth_name)

        class_eval <<-RUBY
          module ActionsWithCallbacks
            define_method(:#{mth_name}) do |*args, &block|
              self.class._callback_chain.before_chain_of(:#{mth_name}).each { |cb| send(cb) }
              super(*args, &block)
              self.class._callback_chain.after_chain_of(:#{mth_name}).each { |cb| send(cb) }
            end
          end
        RUBY

        prepend self::ActionsWithCallbacks
      end
    end
  end

  def validate_method_scope(method_scope)
    disalloed_scope = method_scope.keys - ALLOWED_SCOPE

    if disalloed_scope.empty?
      true
    else
      raise MethodScopeError.new("#{disalloed_scope} contains disallowed scope.")
    end
  end

  class MethodScopeError < StandardError
  end
end