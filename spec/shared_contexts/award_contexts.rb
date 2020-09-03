shared_context 'award class' do
  require 'support/dummy_award'

  let(:klass) do
    Class.new(DummyAward).tap {|klass| klass.send :include, described_class }
  end
end

shared_context 'expired' do
  let(:initial_expires_in) { 0 }
end
