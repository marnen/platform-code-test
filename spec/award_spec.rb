require 'rspec'
require 'shared_examples/award_examples'
require 'award'

RSpec.describe Award do

  let(:name) { "Normal Award #{rand 100}" }
  let(:initial_expires_in) { rand(2..5) }
  let(:initial_quality) { rand(2..45) }

  describe 'constructor' do
    it 'takes parameters for name, expiration, and quality' do
      expect(described_class.new name, initial_expires_in, initial_quality).to be_a_kind_of described_class
    end

    context 'module inclusion' do
      context 'normal award' do
        it 'includes the normal behavior' do
          expect(described_class.new name, initial_expires_in, initial_quality).to be_a_kind_of Awards::Normal
        end
      end

      context 'awards with special rules' do
        it 'includes the appropriate rules module' do
          ['Blue Compare', 'Blue First', 'Blue Distinction Plus'].each do |name|
            mod = Awards.const_get(name.delete ' ')
            expect(described_class.new name, initial_expires_in, initial_quality).to be_a_kind_of mod
          end
        end
      end
    end
  end
end
