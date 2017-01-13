require 'set'

module Callback
  # The chain should have each method that has callback as key
  # and each callback points to a hash with :before, :after as key
  # each of those keys points to an array of callbacks
  # {
  #   method: {
  #     before: [...],
  #     after:  [...]
  #   }
  # }
  class Chain
    CALLBACK_HOOK = [:before, :after].freeze

    def initialize
      CALLBACK_HOOK.each do |cb_hook|
        instance_variable_set("@_#{cb_hook}_chain", new_chain)
      end
    end

    def append_callback(callback_hook, mth, callback)
      chain = get_chain(callback_hook)
      chain[mth] << callback
    end

    # This will define methods to get before / after chain of an action
    # e.g. 
    # before_chain_of(:method_name)
    # this gets all the before actions of :method_name
    CALLBACK_HOOK.each do |cb_hook|
      define_method("#{cb_hook}_chain_of") do |mth_name|
        get_callbacks(cb_hook, mth_name)
      end
    end

    private

    def get_callbacks(callback_hook, mth)
      chain = get_chain(callback_hook)
      chain[mth].dup
    end

    def get_chain(callback_hook)
      instance_variable_get("@_#{callback_hook}_chain")
    end

    def new_chain
      Hash.new { |h, k| h[k] = Set.new }
    end
  end
end