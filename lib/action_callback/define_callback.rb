module ActionCallback
  private

  def initialize_callback_chain(mod)
    mod.define_singleton_method(:_callback_chain) do
      @_callback_chain
    end
  end

  def define_callback(callback_hook)
    define_method("#{callback_hook}_action") do |callback, method_scope|
      @_callback_chain ||= Callback::Chain.new

      method_scope[:on].each do |mth_name|
        _callback_chain.append_callback(callback_hook, mth_name, callback)

        undef_method(mth_name) if included_modules.map(&:to_s).include?('ActionWithCallbacks')

        class_eval <<-RUBY
          module ActionWithCallbacks
            define_method(:#{mth_name}) do |*args, &block|
              self.class._callback_chain.before_chain_of(:#{mth_name}).each { |cb| send(cb) }
              super(*args, &block)
              self.class._callback_chain.after_chain_of(:#{mth_name}).each { |cb| send(cb) }
            end
          end
        RUBY

        prepend self::ActionWithCallbacks
      end
    end
  end
end