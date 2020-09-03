Dir['awards/**/*.rb'].each {|file| require file }

Award = Struct.new(:name, :expires_in, :quality) do
  def initialize(*args)
    super
    become self.name
  end

  def update_quality!
    modify_quality!
    modify_expiration!
  end

  private

  def become(name)
    mod = Awards.const_get name.delete(' ')
    self.singleton_class.send :include, mod
  rescue NameError
    # do nothing
  end

  def modify_quality!
    if self.quality > 0
      self.quality -= 1
    end
    if self.expires_in <= 0
      if self.quality > 0
        self.quality -= 1
      end
    end
  end

  def modify_expiration!
    self.expires_in -= 1
  end
end
