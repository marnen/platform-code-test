require 'awards/countdown'

module Awards
  module BlueCompare
    include Countdown

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
      self.quality = [self.quality, 50].min
    end
  end
end
