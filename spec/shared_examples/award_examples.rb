shared_examples 'decrement count of days' do
  it 'decrements the count of days till expiration' do
    expect(update!).to change { award.expires_in }.by -1
  end
end

shared_examples 'quality does not go over 50' do
  context do
    let(:initial_quality) { 50 }

    it 'does not increase quality above 50' do
      update!.call
      expect(award.quality).not_to be > 50
    end
  end
end

shared_examples 'quality is never negative' do
  context do
    let(:initial_quality) { 0 }

    it 'does not lower the quality below 0' do
      update!.call
      expect(award.quality).not_to be < 0
    end
  end
end
