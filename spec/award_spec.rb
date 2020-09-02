require 'rspec'
require 'award'

RSpec.describe Award do
  let(:name) { "Normal Award #{rand 100}" }
  let(:initial_expires_in) { rand(2..5) }
  let(:initial_quality) { rand(1..45) }

  let(:award) { described_class.new name, initial_expires_in, initial_quality }

  describe '#update_quality!' do
    let(:update!) { -> { award.update_quality! } }

    shared_examples 'decrement count of days' do
      it 'decrements the count of days till expiration' do
        expect(update!).to change { award.expires_in }.by -1
      end
    end

    shared_context 'expired' do
      let(:initial_expires_in) { 0 }
    end

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

    context 'awards with increasing quality' do
      shared_examples 'quality does not go over 50' do
        context do
          let(:initial_quality) { 50 }

          it 'does not increase quality above 50' do
            expect(update!).not_to change { award.quality }
          end
        end
      end

      context 'Blue First' do
        let(:name) { 'Blue First' }

        context 'unexpired' do
          include_examples 'decrement count of days'
          include_examples 'quality does not go over 50'

          it 'increments the quality by 1' do
            expect(update!).to change { award.quality }.by 1
          end
        end

        context 'expired' do
          include_context 'expired'

          include_examples 'decrement count of days'
          include_examples 'quality does not go over 50'

          it 'increments the quality by 2' do
            expect(update!).to change { award.quality }.by 2
          end
        end
      end

      context 'Blue Compare' do
        let(:name) { 'Blue Compare' }

        context 'more than 10 days left' do
          let(:initial_expires_in) { rand(11..50) }

          include_examples 'decrement count of days'
          include_examples 'quality does not go over 50'

          it 'increments the quality by 1' do
            expect(update!).to change { award.quality }.by 1
          end
        end

        context '6-10 days left' do
          let(:initial_expires_in) { rand(6..10) }

          include_examples 'decrement count of days'
          include_examples 'quality does not go over 50'

          it 'increments the quality by 2' do
            expect(update!).to change { award.quality }.by 2
          end
        end

        context '1-5 days left' do
          let(:initial_expires_in) { rand(1..5) }

          include_examples 'decrement count of days'
          include_examples 'quality does not go over 50'

          it 'increments the quality by 3' do
            expect(update!).to change { award.quality }.by 3
          end
        end

        context 'expired' do
          include_context 'expired'

          include_examples 'decrement count of days'

          it 'sets the quality to 0' do
            update!.call
            expect(award.quality).to be_zero
          end
        end
      end
    end

    context 'Blue Distinction Plus' do
      let(:name) { 'Blue Distinction Plus' }

      it 'does not change quality' do
        expect(update!).not_to change { award.quality }
      end

      it 'does not change expiration' do
        expect(update!).not_to change { award.expires_in }
      end
    end
  end
end
