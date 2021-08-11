require_relative '../exceptions'

module WebserverLogParser
  module Source
    class FileReader
      def content(path)
        return @content if defined?(@content)

        file = File.open(path, 'r')
        @content = file.read
      rescue WebserverLogParser::Exceptions::FileNotFoundError
        raise WebserverLogParser::Exceptions::SourceNotFoundError
      ensure
        file&.close
      end
    end
  end
end
