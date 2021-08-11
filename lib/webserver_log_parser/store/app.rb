require_relative './db'

module WebserverLogParser
  module Store
    class App
      def initialize(db: WebserverLogParser::Store::Db.new)
        self.db = db
      end

      def call(content)
        db.setup
        insert_records(content)
        yield(db.webserver_view)
      end

      private

      attr_accessor :db

      def insert_records(content)
        content.split(/\n/).each do |line|
          route, ip = line.split
          db.webserver_view.create(route: route, ip: ip)
        end
      end
    end
  end
end
