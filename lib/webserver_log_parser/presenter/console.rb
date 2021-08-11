module WebserverLogParser
  module Presenter
    class Console
      def initialize(rows:, text:)
        self.rows = rows
        self.text = text
      end

      def call
        rows.each do |row|
          puts [row[:route], row[:count], pluralize(text, count: row[:count])].join(' ')
        end
      end

      private

      attr_accessor :rows, :text

      def pluralize(text, count:)
        count == 1 ? text : "#{text}s"
      end
    end
  end
end
