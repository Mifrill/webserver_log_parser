require 'webserver_log_parser/presenter/app'

describe WebserverLogParser::Presenter::App do
  subject(:presenter) do
    described_class.new
  end

  let(:console_klass) { WebserverLogParser::Presenter::Console }
  let(:console) { instance_double(console_klass) }
  let(:rows) { [{ key: 1 }] }
  let(:rows2) { [{ key: 2 }] }
  let(:rows3) { [{ key: 3 }] }

  let(:data) do
    [
      rows,
      rows2,
      rows3
    ]
  end

  describe '#call' do
    it 'prints proper output' do
      expect(console_klass).to receive(:new).once.and_return(console)
      expect(console).to receive(:call).with(rows: rows, text: 'visit').once
      expect(console).to receive(:call).with(rows: rows2, text: 'unique view').once
      expect(console).to receive(:call).with(rows: rows3, text: 'average view').once
      presenter.call(data)
    end
  end
end
