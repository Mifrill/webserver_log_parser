require 'webserver_log_parser/source/file_reader'

describe WebserverLogParser::Source::FileReader do
  subject(:file_reader) do
    described_class.new
  end

  let(:file_klass) { File }
  let(:file) { instance_double(file_klass) }

  describe '#content' do
    it 'returns file content' do
      allow(file_klass).to receive(:open).with('test-file-path.log', 'r').and_return(file)
      allow(file).to receive(:read).and_return('test-file-content')
      expect(file).to receive(:close).with(no_args).once
      expect(file_reader.content('test-file-path.log')).to eq('test-file-content')
    end

    context 'with multiple calls' do
      it 'return memoized file content' do
        expect(file_klass).to receive(:open).once.and_return(file)
        expect(file).to receive(:read).with(no_args).once
        expect(file).to receive(:close).with(no_args).once
        2.times { file_reader.content('test-file-path.log') }
      end
    end

    context 'when file not exists' do
      it 'raises SourceNotFoundError with proper message' do
        expect { file_reader.content('test-file-path.log') }
          .to raise_exception(WebserverLogParser::Exceptions::SourceNotFoundError,
                              'Source not found | check provided Path as first argument')
      end
    end
  end
end
