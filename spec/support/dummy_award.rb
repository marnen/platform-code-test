class DummyAward
  attr_accessor :expires_in, :quality

  def initialize(expires_in:, quality:)
    @expires_in = expires_in
    @quality = quality
  end
end
