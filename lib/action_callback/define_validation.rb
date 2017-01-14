module ActionCallback
  private

  def initialize_validation_chain(mod)
    mod.define_singleton_method(:_validation_chain) do
      @_validation_chain
    end
  end

  def define_validation
    define_method(:validate) do |*args, &block|
      @_validation_chain ||= Validation::Chain.new

      options = args.last
      if options.key?(:before)
        validator_mth_name = args.first
        options[:before].each do |mth_name|
          _validation_chain.append(:before, mth_name, validator_mth_name)
          undef_method(mth_name) if included_modules.map(&:to_s).include?('ActionWithValidations')

          class_eval <<-RUBY
            module ActionWithValidations
              define_method(:#{mth_name}) do |*args, &block|
                self.class._validation_chain.before_chain_of(:#{mth_name}).each { |v| send(v) }

                should_run = true
                should_run = !errors.present? if self.class.ancestors.include?(ActiveRecord::Base)

                super(*args, &block) if should_run
              end
            end
          RUBY

          prepend self::ActionWithValidations
        end
      else
        super(*args, &block)
      end
    end
  end
end