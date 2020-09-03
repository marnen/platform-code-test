require 'awards/countdown'

module Awards
  module BlueStar
    include Countdown
    include NormalizeQuality

    def update_quality!
      modify_quality!
      countdown!
    end

    private

    def modify_quality!
      self.quality -= self.expires_in <= 0 ? 4 : 2
      normalize_quality!
    end
  end
end
