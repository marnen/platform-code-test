module Awards
  module Countdown
    def countdown!
      self.expires_in -= 1
    end
  end
end
