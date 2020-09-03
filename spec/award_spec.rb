require 'rspec'
require 'shared_examples/award_examples'
require 'award'

RSpec.describe Award do
  let(:name) { "Normal Award #{rand 100}" }
  let(:initial_expires_in) { rand(2..5) }
  let(:initial_quality) { rand(2..45) }

  let(:award) { described_class.new name, initial_expires_in, initial_quality }

  describe '#update_quality!' do
    let(:update!) { -> { award.update_quality! } }

    context 'conventional award' do
      shared_examples 'quality is never negative' do
        context do
          let(:initial_quality) { 0 }

          it 'does not lower the quality below 0' do
            expect(update!).not_to change { award.quality }
          end
        end
      end

      context 'unexpired' do
        include_examples 'decrement count of days'
        include_examples 'quality is never negative'

        it 'decrements the quality by 1' do
          expect(update!).to change { award.quality }.by -1
        end
      end

      context 'expired' do
        include_context 'expired'

        include_examples 'decrement count of days'
        include_examples 'quality is never negative'

        it 'decrements the quality by 2' do
          expect(update!).to change { award.quality }.by -2
        end
      end
    end

    context 'awards with special rules' do
      subject { award }

      it 'includes a module for each set of special rules' do
        ['Blue Compare', 'Blue First', 'Blue Distinction Plus'].each do |name|
          expect(described_class.new name, 0, 0).to be_a_kind_of Awards.const_get(name.delete ' ')
        end
      end
    end
  end
end
