module Awards
  module Countdown
    def countdown!
      self.expires_in -= 1
    end

    def expired?
      self.expires_in <= 0
    end
  end
end
