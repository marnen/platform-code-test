require 'rspec'
require 'shared_contexts/award_contexts'
require 'awards/blue_distinction_plus'

RSpec.describe Awards::BlueDistinctionPlus do
  include_context 'award class'

  let(:initial_expires_in) { rand(-10..10) }
  let(:initial_quality) { rand(1..45) }
  let(:award) { klass.new expires_in: initial_expires_in, quality: initial_quality }

  describe '#update_quality!' do
    let(:update!) { -> { award.update_quality! } }

    it 'does not change quality' do
      expect(update!).not_to change { award.quality }
    end

    it 'does not change expiration' do
      expect(update!).not_to change { award.expires_in }
    end
  end
end
