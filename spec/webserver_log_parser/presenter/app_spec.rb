require 'webserver_log_parser/presenter/app'
require 'ostruct'

describe WebserverLogParser::Presenter::App do
  subject(:presenter) do
    described_class.new(settings: settings)
  end

  let(:settings) { OpenStruct.new(locale: locale) }
  let(:locale) { 'en' }
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
      expect(console).to receive(:call).with(rows: rows2, text: 'unique visit').once
      expect(console).to receive(:call).with(rows: rows3, text: 'average visit').once
      presenter.call(data)
    end

    context 'when locale - es' do
      let(:locale) { 'es' }

      it 'prints proper output' do
        expect(console_klass).to receive(:new).once.and_return(console)
        expect(console).to receive(:call).with(rows: rows, text: 'visita').once
        expect(console).to receive(:call).with(rows: rows2, text: 'única visita').once
        expect(console).to receive(:call).with(rows: rows3, text: 'promedio visita').once
        presenter.call(data)
      end
    end
  end
end
