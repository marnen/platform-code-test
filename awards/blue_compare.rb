require 'awards/basic_behavior'

module Awards
  module BlueCompare
    include BasicBehavior

    def update_quality!
      modify_quality!
      countdown!
    end

    private

    def modify_quality!
      if self.expires_in >= 11
        self.quality += 1
      elsif self.expires_in >= 6
        self.quality += 2
      elsif self.expires_in >= 1
        self.quality += 3
      else
        self.quality = 0
      end
      normalize_quality!
    end
  end
end
