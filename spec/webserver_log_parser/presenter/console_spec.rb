require 'webserver_log_parser/presenter/console'

describe WebserverLogParser::Presenter::Console do
  subject(:console) do
    described_class.new(rows: rows, text: 'item')
  end

  let(:rows) do
    [
      { route: 'test-route', count: 1 }
    ]
  end

  describe '#call' do
    it 'prints proper output' do
      expect($stdout).to receive(:puts).with('test-route 1 item').once
      console.call
    end

    context 'when few rows' do
      let(:rows) do
        [
          { route: 'test-route-1', count: 1 },
          { route: 'test-route-2', count: 1 }
        ]
      end

      it 'prints proper output for each row' do
        expect($stdout).to receive(:puts).with('test-route-1 1 item').once
        expect($stdout).to receive(:puts).with('test-route-2 1 item').once
        console.call
      end
    end

    context 'when counter more than 1' do
      let(:rows) do
        [
          { route: 'test-route', count: 2 }
        ]
      end

      it 'prints pluralized text' do
        expect($stdout).to receive(:puts).with('test-route 2 items').once
        console.call
      end
    end
  end
end
