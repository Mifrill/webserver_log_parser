require 'webserver_log_parser/app'

describe WebserverLogParser::App do
  subject(:app) do
    described_class.new(
      cli: cli,
      source: source,
      store: store,
      aggregator: aggregator,
      presenter: presenter
    )
  end

  let(:cli) { instance_double(WebserverLogParser::Cli::App) }
  let(:source) { instance_double(WebserverLogParser::Source::App) }
  let(:store) { instance_double(WebserverLogParser::Store::App) }
  let(:aggregator) { instance_double(WebserverLogParser::Aggregator::App) }
  let(:presenter) { instance_double(WebserverLogParser::Presenter::App) }

  before do
    WebserverLogParser.load
  end

  describe '#call' do
    it 'returns output by calls chain of nested objects' do
      allow(cli).to receive(:call).with('test-argv').and_yield('test-path')
      allow(source).to receive(:call).with('test-path').and_yield('test-content')
      allow(store).to receive(:call).with('test-content').and_yield('test-scope')
      allow(aggregator).to receive(:call).with('test-scope').and_yield('test-data')
      allow(presenter).to receive(:call).with('test-data').and_return('test-output')
      expect(app.call('test-argv')).to eq('test-output')
    end

    context 'when exception raised' do
      it 'rescues exception with message output' do
        allow(cli).to receive(:call).with('test-argv').and_raise(StandardError.new('test message'))
        expect(WebserverLogParser::Exceptions).to receive(:print).with('test message')
        app.call('test-argv')
      end
    end
  end
end
