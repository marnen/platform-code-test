module Awards
  module BasicBehavior
    def countdown!
      self.expires_in -= 1
    end

    def expired?
      self.expires_in <= 0
    end

    def normalize_quality!
      max_quality = 50
      min_quality = 0
      self.quality = [[self.quality, max_quality].min, min_quality].max
    end

    def update_quality!
      modify_quality!
      countdown!
    end
  end
end
