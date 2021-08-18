require 'sequel'
require 'pp'
require 'byebug'

db = Sequel.sqlite
Sequel::Model.db = db

db.create_table :webserver_views do
  primary_key :id
  String :route, null: false
  String :ip, null: false
end

require 'webserver_log_parser/store/models/webserver_view'

describe WebserverLogParser::Store::Models::WebserverView do
  before do
    described_class.all.map(&:destroy)
  end

  shared_examples 'when same IP' do
    context 'when same IP' do
      before do
        described_class.create(route: '/help_page/1', ip: '126.318.035.038')
        described_class.create(route: '/help_page/1', ip: '126.318.035.038')
      end

      it 'returns grouped rows with proper counter by uniq ip' do
        expect(described_class.public_send(scope).to_a.map(&:values))
          .to match_array(expected_rows)
      end
    end
  end

  shared_examples 'when different rows' do
    context 'when different rows' do
      before do
        described_class.create(route: '/help_page/1', ip: '126.318.035.038')
        described_class.create(route: '/contact', ip: '126.318.035.038')
      end

      let(:expected_rows) do
        [
          { route: '/help_page/1', count: 1 },
          { route: '/contact', count: 1 }
        ]
      end

      it 'returns grouped rows for each route' do
        expect(described_class.public_send(scope).to_a.map(&:values))
          .to match_array(expected_rows)
      end
    end
  end

  shared_examples 'when different IP for same route' do
    context 'when different IP for same route' do
      before do
        described_class.create(route: '/help_page/1', ip: '126.318.035.038')
        described_class.create(route: '/help_page/1', ip: '126.318.035.000')
      end

      it 'returns grouped rows with proper counter' do
        expect(described_class.public_send(scope).to_a.map(&:values))
          .to match_array(
            [
              { route: '/help_page/1', count: 2 }
            ]
          )
      end
    end
  end

  describe '.total_pages_views' do
    let(:scope) { :total_pages_views }

    include_examples 'when same IP' do
      let(:expected_rows) do
        [
          { route: '/help_page/1', count: 2 }
        ]
      end
    end

    include_examples 'when different rows'
    include_examples 'when different IP for same route'
  end

  describe '.unique_pages_views' do
    include_examples 'when same IP' do
      let(:scope) { :unique_pages_views }
      let(:expected_rows) do
        [
          { route: '/help_page/1', count: 1 }
        ]
      end
    end

    include_examples 'when different rows'
    include_examples 'when different IP for same route'
  end

  describe '.order_by_most_views' do
    before do
      described_class.create(route: '/help_page/1', ip: '126.318.035.038')
      described_class.create(route: '/contact/1', ip: '126.318.035.000')
      described_class.create(route: '/contact/1', ip: '126.318.035.000')
    end

    it 'returns grouped rows with proper counter' do
      expect(described_class.group_and_count(:route).order_by_most_views.to_a.map(&:values))
        .to match_array(
          [
            { route: '/contact/1', count: 2 },
            { route: '/help_page/1', count: 1 }
          ]
        )
    end

    context 'when count column not persist' do
      it 'returns grouped rows with proper counter' do
        expect { described_class.group(:route).order_by_most_views.to_a }
          .to raise_exception(Sequel::DatabaseError, /no such column: count/)
      end
    end
  end

  describe '#validate' do
    pending('simplecov shows 100% with no validation checks | use https://github.com/mbj/mutant')
  end

  describe '.average_pages_views average number of page views' do
    before do
      described_class.create(route: '/home', ip: '126.318.035.000')
      described_class.create(route: '/home', ip: '126.318.035.000')
      described_class.create(route: '/home', ip: '126.318.035.001')
    end

    it 'returns grouped rows ' do
      expect(described_class.average_pages_views.to_a.map(&:values))
        .to match_array(
          [
            { route: '/home', count: 1.5 }
          ]
        )
    end
  end
end
