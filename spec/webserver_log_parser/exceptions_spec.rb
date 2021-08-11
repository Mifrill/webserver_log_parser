require 'webserver_log_parser/exceptions'

describe WebserverLogParser::Exceptions do
  describe '.print' do
    it 'returns output by calls chain of nested objects' do
      expect(PP).to receive(:pp).with('message')
      described_class.print('message')
    end
  end
end
