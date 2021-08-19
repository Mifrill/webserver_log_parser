module WebserverLogParser
  module Presenter
    class Console
      def call(rows:, text:)
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
