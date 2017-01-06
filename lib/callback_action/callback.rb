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
    def initialize
      @_chain = {}
    end

    def append_callback(mth, callback_hook, callback)
      @_chain[mth] ||= {}
      @_chain[mth][callback_hook] ||= Set.new
      @_chain[mth][callback_hook] << callback
    end

    def get_callbacks(mth)
      @_chain[mth]
    end
  end

  class << self
    def get_callbacks(mth)
      @_callback_chain.get_callbacks[mth]
    end
  end
end