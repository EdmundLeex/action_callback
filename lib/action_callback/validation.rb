require 'set'

module Validation
  class Chain
    VALIDATION_HOOK = [:before].freeze

    def initialize
      VALIDATION_HOOK.each do |cb_hook|
        instance_variable_set("@_#{cb_hook}_chain", new_chain)
      end
    end

    def append_validation(validation_hook, mth, validation)
      chain = get_chain(validation_hook)
      chain[mth] << validation
    end

    VALIDATION_HOOK.each do |cb_hook|
      define_method("#{cb_hook}_chain_of") do |mth_name|
        get_validations(cb_hook, mth_name)
      end
    end

    private

    def get_validations(validation_hook, mth)
      chain = get_chain(validation_hook)
      chain[mth].dup
    end

    def get_chain(validation_hook)
      instance_variable_get("@_#{validation_hook}_chain")
    end

    def new_chain
      Hash.new { |h, k| h[k] = Set.new }
    end
  end

  class << self
    def get_validations(mth)
      @_validation_chain.get_validations[mth]
    end
  end
end