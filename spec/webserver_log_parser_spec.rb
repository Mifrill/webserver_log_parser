describe WebserverLogParser do
  describe '.load' do
    it 'requires app files' do
      expect { described_class.load }.to avoid_exception
    end

    context 'when loaded' do
      before do
        described_class.load
      end

      specify { expect(WebserverLogParser::Cli::App).to be_kind_of(Class) }
      specify { expect(WebserverLogParser::Source::App).to be_kind_of(Class) }
      specify { expect(WebserverLogParser::Store::App).to be_kind_of(Class) }
      specify { expect(WebserverLogParser::Presenter::App).to be_kind_of(Class) }
    end
  end

  describe '.run' do
    before do
      described_class.load
    end

    let(:app_klass) { WebserverLogParser::App }
    let(:app) { instance_double(app_klass) }

    it 'calls WebserverLogParser::App with passed argument' do
      expect(app_klass).to receive(:new).with(
        cli: be_instance_of(WebserverLogParser::Cli::App),
        source: be_instance_of(WebserverLogParser::Source::App),
        store: be_instance_of(WebserverLogParser::Store::App),
        aggregator: be_instance_of(WebserverLogParser::Aggregator::App),
        presenter: be_instance_of(WebserverLogParser::Presenter::App)
      ).once.and_return(app)
      expect(app).to receive(:call).once.with('test-source-path')
      described_class.run('test-source-path')
    end
  end
end
