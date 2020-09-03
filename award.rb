Dir['awards/**/*.rb'].each {|file| require file }

Award = Struct.new(:name, :expires_in, :quality) do
  def initialize(*args)
    super
    load_rules
  end

  private

  def load_rules
    mod = begin
      Awards.const_get self.name.delete(' ')
    rescue NameError
      Awards::Normal
    end
    self.singleton_class.send :include, mod
  end
end
