require 'awards/basic_behavior'

module Awards
  class Linear < Module
    # technique from https://medium.com/@eric.programmer/arguments-for-included-modules-in-ruby-8056b9fa2743
    def initialize(daily_change:, expired_multiplier: 2)
      super() do
        include BasicBehavior

        def update_quality!
          modify_quality!
          countdown!
        end

        private

        define_method :daily_change do
          daily_change
        end

        define_method :expired_multiplier do
          expired_multiplier
        end

        def modify_quality!
          effective_change = daily_change
          effective_change *= expired_multiplier if expired?
          self.quality += effective_change
          normalize_quality!
        end
      end
    end
  end
end
