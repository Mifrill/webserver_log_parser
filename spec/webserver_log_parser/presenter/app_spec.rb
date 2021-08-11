require 'webserver_log_parser/presenter/app'

describe WebserverLogParser::Presenter::App do
  subject(:presenter) do
    described_class.new
  end

  let(:console_klass) { WebserverLogParser::Presenter::Console }
  let(:console) { instance_double(console_klass) }
  let(:rows) { [{ key: 1 }] }
  let(:rows2) { [{ key: 2 }] }

  let(:data) do
    [
      rows,
      rows2
    ]
  end

  describe '#call' do
    it 'prints proper output' do
      expect(console_klass).to receive(:new).with(rows: rows, text: 'visit').once.and_return(console)
      expect(console).to receive(:call).with(no_args).once
      expect(console_klass).to receive(:new).with(rows: rows2, text: 'unique view').once.and_return(console)
      expect(console).to receive(:call).with(no_args).once
      presenter.call(data)
    end
  end
end
