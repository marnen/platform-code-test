require 'awards/countdown'

module Awards
  module BlueStar
    include Countdown

    def update_quality!
      modify_quality!
      countdown!
    end

    private

    def modify_quality!
      if self.quality > 0
        self.quality -= 2
      end
      if self.expires_in <= 0
        if self.quality > 0
          self.quality -= 2
        end
      end
    end
  end
end
