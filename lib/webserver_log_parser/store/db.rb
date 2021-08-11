require 'sequel'

module WebserverLogParser
  module Store
    class Db
      def initialize(db: Sequel.sqlite)
        self.db = db
      end

      def setup
        Sequel::Model.db = db
        create_webserver_views
      end

      def webserver_view
        WebserverLogParser::Store::Models::WebserverView
      end

      private

      attr_accessor :db

      def create_webserver_views
        db.create_table :webserver_views do
          primary_key :id
          String :route, null: false
          String :ip, null: false
        end
        require_relative './models/webserver_view'
      end
    end
  end
end
