require 'webserver_log_parser/source/app'

describe WebserverLogParser::Source::App do
  subject(:source) do
    described_class.new
  end

  let(:file_reader_klass) { WebserverLogParser::Source::FileReader }
  let(:file_reader) { instance_double(file_reader_klass) }

  describe '#call' do
    it 'yields with file content' do
      allow(file_reader_klass).to receive(:new).with(no_args).and_return(file_reader)
      allow(file_reader).to receive(:content).with('test-file-path.log').and_return('test-file-content')
      expect { |block| source.call('test-file-path.log', &block) }.to yield_with_args('test-file-content')
    end
  end
end
