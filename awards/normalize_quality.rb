module Awards
  module NormalizeQuality
    def normalize_quality!
      max_quality = 50
      min_quality = 0
      self.quality = [[self.quality, max_quality].min, min_quality].max
    end
  end
end
