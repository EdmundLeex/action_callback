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
      @_chain = {}
    end

    def append_callback(callback_hook, mth, callback)
      chain = get_chain(callback_hook)
      chain[mth] << callback
      # @_chain[mth] ||= {}
      # @_chain[mth][callback_hook] ||= Set.new
      # @_chain[mth][callback_hook] << callback
    end

    def get_callbacks(callback_hook, mth)
      chain = get_chain(callback_hook)
      chain[mth].dup
      # @_chain[mth]
    end

    private

    def get_chain(callback_hook)
      instance_variable_get("@_#{callback_hook}_chain")
    end

    def new_chain
      Hash.new { |h, k| h[k] = [] }
    end
  end

  class << self
    def get_callbacks(mth)
      @_callback_chain.get_callbacks[mth]
    end
  end
end