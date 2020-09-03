shared_context 'expired' do
  let(:initial_expires_in) { 0 }
end

shared_examples 'decrement count of days' do
  it 'decrements the count of days till expiration' do
    expect(update!).to change { award.expires_in }.by -1
  end
end

shared_examples 'quality does not go over 50' do
  context do
    let(:initial_quality) { 50 }

    it 'does not increase quality above 50' do
      expect(update!).not_to change { award.quality }
    end
  end
end

shared_examples 'quality is never negative' do
  context do
    let(:initial_quality) { 0 }

    it 'does not lower the quality below 0' do
      expect(update!).not_to change { award.quality }
    end
  end
end
