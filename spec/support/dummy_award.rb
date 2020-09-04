class DummyAward
  attr_accessor :expires_in, :quality

  def initialize(expires_in: 0, quality: 0)
    @expires_in = expires_in
    @quality = quality
  end
end
