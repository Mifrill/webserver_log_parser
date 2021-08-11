require 'webserver_log_parser/store/app'

describe WebserverLogParser::Store::App do
  subject(:store) do
    described_class.new
  end

  let(:db_klass) { WebserverLogParser::Store::Db }
  let(:db) { instance_double(db_klass) }
  let(:webserver_view) { instance_double('webserver_view') }

  let(:content) do
    <<~INFO
      line 1
      line 2
    INFO
  end

  describe '#call' do
    it 'yields prepared model' do
      allow(db_klass).to receive(:new).with(no_args).and_return(db)
      expect(db).to receive(:setup).with(no_args)
      expect(db).to receive(:webserver_view).with(no_args).exactly(3).times.and_return(webserver_view)
      expect(webserver_view).to receive(:create).with(route: 'line', ip: '1').once
      expect(webserver_view).to receive(:create).with(route: 'line', ip: '2').once
      expect { |block| store.call(content, &block) }
        .to yield_with_args(webserver_view)
    end
  end
end
