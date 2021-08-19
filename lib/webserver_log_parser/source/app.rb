require_relative './file_reader'

module WebserverLogParser
  module Source
    class App
      def initialize(source: FileReader.new)
        self.source = source
      end

      def call(path)
        source.content(path)
      end

      private

      attr_accessor :source
    end
  end
end
