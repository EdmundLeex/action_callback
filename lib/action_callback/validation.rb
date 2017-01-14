require 'set'

module Validation
  HOOKS = [:before].freeze

  class Chain
    HOOKS.each do |cb_hook|
      define_method("#{cb_hook}_chain_of") do |mth_name|
        get_hook(cb_hook, mth_name)
      end
    end

    def initialize
      HOOKS.each do |cb_hook|
        instance_variable_set("@_#{cb_hook}_chain", new_chain)
      end
    end

    def append(hook_name, mth, hook_mth)
      chain = get_chain(hook_name)
      chain[mth] << hook_mth
    end

    private

    def get_hook(hook_name, mth)
      chain = get_chain(hook_name)
      chain[mth].dup
    end

    def get_chain(hook_name)
      instance_variable_get("@_#{hook_name}_chain")
    end

    def new_chain
      Hash.new { |h, k| h[k] = Set.new }
    end
  end
end