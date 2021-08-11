require_relative '../exceptions'

module WebserverLogParser
  module Cli
    module Validator
      def validate(argv)
        raise WebserverLogParser::Exceptions::CliArgumentsError unless argv[1].nil?
        raise WebserverLogParser::Exceptions::EmptyPathError if argv[0].empty?

        argv[0]
      end
    end
  end
end
