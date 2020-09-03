shared_examples 'decrement count of days' do
  it 'decrements the count of days till expiration' do
    expect(update!).to change { award.expires_in }.by -1
  end
end

shared_context 'expired' do
  let(:initial_expires_in) { 0 }
end
