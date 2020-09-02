Award = Struct.new(:name, :expires_in, :quality) do
  def update_quality!
    modify_quality!
    modify_expiration!
  end

  private

  def modify_quality!
    case self.name
    when 'Blue First'
      if self.quality < 50
        self.quality += 1
      end
      if self.expires_in <= 0
        if self.quality < 50
          self.quality += 1
        end
      end
    when 'Blue Compare'
      if self.quality < 50
        self.quality += 1
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
      if self.expires_in <= 0
        self.quality = 0
      end
    when 'Blue Distinction Plus'
      # do nothing
    else
      if self.quality > 0
        self.quality -= 1
      end
      if self.expires_in <= 0
        if self.quality > 0
          self.quality -= 1
        end
      end
    end
  end

  def modify_expiration!
    case self.name
    when 'Blue First', 'Blue Compare'
      self.expires_in -= 1
    when 'Blue Distinction Plus'
      # do nothing
    else
      self.expires_in -= 1
    end
  end
end
