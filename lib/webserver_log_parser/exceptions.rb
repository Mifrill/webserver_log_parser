require 'pp'

module WebserverLogParser
  module Exceptions
    class CliEmptyPathError < StandardError
      def message
        'Path to source is empty | should be as first argument'
      end
    end

    class CliLocaleError < StandardError
      def message
        "We are didn't support this locale"
      end
    end

    class CliArgumentsCountError < StandardError
      def message
        'Cannot proceed with third argument'
      end
    end

    class FileNotFoundError < StandardError
      def self.===(exception)
        exception.is_a?(Errno::ENOENT) &&
          /No such file or directory/.match?(exception.message)
      end
    end

    class SourceNotFoundError < StandardError
      def message
        'Source not found | check provided Path as first argument'
      end
    end

    def self.print(error)
      PP.pp error
    end
  end
end
