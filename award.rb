Award = Struct.new(:name, :expires_in, :quality) do
  def update_quality!
    if self.name != 'Blue First' && self.name != 'Blue Compare'
      if self.quality > 0
        if self.name != 'Blue Distinction Plus'
          self.quality -= 1
        end
      end
    else
      if self.quality < 50
        self.quality += 1
        if self.name == 'Blue Compare'
          if self.expires_in < 11
            if self.quality < 50
              self.quality += 1
            end
          end
          if self.expires_in < 6
            if self.quality < 50
              self.quality += 1
            end
          end
        end
      end
    end
    if self.name != 'Blue Distinction Plus'
      self.expires_in -= 1
    end
    if self.expires_in < 0
      if self.name != 'Blue First'
        if self.name != 'Blue Compare'
          if self.quality > 0
            if self.name != 'Blue Distinction Plus'
              self.quality -= 1
            end
          end
        else
          self.quality = self.quality - self.quality
        end
      else
        if self.quality < 50
          self.quality += 1
        end
      end
    end
  end
end
