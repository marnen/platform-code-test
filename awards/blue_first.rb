require 'awards/countdown'

module Awards
  module BlueFirst
    include Countdown

    def update_quality!
      modify_quality!
      countdown!
    end

    private

    def modify_quality!
      if self.quality < 50
        self.quality += 1
      end
      if self.expires_in <= 0
        if self.quality < 50
          self.quality += 1
        end
      end
    end
  end
end
