require 'webserver_log_parser/aggregator/app'

describe WebserverLogParser::Aggregator::App do
  subject(:aggregator) do
    described_class.new
  end

  let(:scope) do
    instance_double('scope')
  end

  describe '#call' do
    it 'yields array with views' do
      expect(scope).to receive(:total_pages_views).once.with(no_args).and_return(scope)
      expect(scope).to receive(:order_by_most_views).once.with(no_args).and_return(scope)
      expect(scope).to receive(:to_a).once.with(no_args).and_return(['total_pages_views-rows'])
      expect(scope).to receive(:unique_pages_views).once.with(no_args).and_return(scope)
      expect(scope).to receive(:order_by_most_views).once.with(no_args).and_return(scope)
      expect(scope).to receive(:to_a).once.with(no_args).and_return(['order_by_most_views-rows'])
      expect(scope).to receive(:average_pages_views).once.with(no_args).and_return(scope)
      expect(scope).to receive(:order_by_most_views).once.with(no_args).and_return(scope)
      expect(scope).to receive(:to_a).once.with(no_args).and_return(['average_pages_views-rows'])
      expect { |block| aggregator.call(scope, &block) }
        .to yield_with_args([['total_pages_views-rows'], ['order_by_most_views-rows'], ['average_pages_views-rows']])
    end
  end
end
