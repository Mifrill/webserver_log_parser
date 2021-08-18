require_relative './console'

module WebserverLogParser
  module Presenter
    class App
      def initialize(output: WebserverLogParser::Presenter::Console.new)
        self.output = output
      end

      def call(data)
        total_pages_views, unique_pages_views, average_pages_views = *data
        {
          total_pages_views => 'visit',
          unique_pages_views => 'unique view',
          average_pages_views => 'average view'
        }.each { |rows, text| output.call(rows: rows, text: text) }
      end

      private

      attr_accessor :output
    end
  end
end
