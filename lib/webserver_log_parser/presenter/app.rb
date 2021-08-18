require_relative './console'

module WebserverLogParser
  module Presenter
    class App
      def initialize(output_klass: WebserverLogParser::Presenter::Console)
        self.output_klass = output_klass
      end

      def call(data)
        total_pages_views, unique_pages_views, average_pages_views = *data
        {
          total_pages_views => 'visit',
          unique_pages_views => 'unique view',
          average_pages_views => 'average view'
        }.each { |rows, text| output_klass.new(rows: rows, text: text).call }
      end

      private

      attr_accessor :output_klass
    end
  end
end
