module Awards
  module BlueFirst
    def update_quality!
      modify_quality!
      self.expires_in -= 1
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
