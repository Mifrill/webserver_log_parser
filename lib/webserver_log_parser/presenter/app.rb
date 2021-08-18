require_relative './console'

module WebserverLogParser
  module Presenter
    class App
      def initialize(output_klass: WebserverLogParser::Presenter::Console)
        self.output_klass = output_klass
      end

      def call(data)
        total_pages_views, unique_pages_views, average_pages_views = *data
        output_klass.new(
          rows: total_pages_views,
          text: 'visit'
        ).call
        output_klass.new(
          rows: unique_pages_views,
          text: 'unique view'
        ).call
        output_klass.new(
          rows: average_pages_views,
          text: 'average view'
        ).call
      end

      private

      attr_accessor :output_klass
    end
  end
end
