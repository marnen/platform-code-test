require 'awards/basic_behavior'

module Awards
  module Normal
    include BasicBehavior

    def update_quality!
      modify_quality!
      countdown!
    end

    private

    def modify_quality!
      self.quality -= expired? ? 2 : 1
      normalize_quality!
    end
  end
end
