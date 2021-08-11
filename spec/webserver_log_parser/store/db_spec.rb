require 'webserver_log_parser/store/db'

describe WebserverLogParser::Store::Db do
  subject(:db) do
    described_class.new(db: db_mock)
  end

  let(:db_mock) { Sequel.mock }

  describe '#webserver_view' do
    it 'returns WebserverView model' do
      db.setup
      expect(db.webserver_view).to eq(WebserverLogParser::Store::Models::WebserverView)
    end
  end

  describe '#setup' do
    subject(:sql) do
      db_mock.sqls[0]
    end

    before do
      db.setup
    end

    it 'creates webserver_views table' do
      expect(sql).to match(/CREATE TABLE webserver_views \(id integer PRIMARY KEY AUTOINCREMENT/)
    end

    it 'creates route as string ' do
      expect(sql).to match(/, route varchar\(255\) NOT NULL, ip varchar\(255\) NOT NULL/)
    end
  end
end
