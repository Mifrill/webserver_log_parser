require_relative './validator'

module WebserverLogParser
  module Cli
    class App
      include Validator

      def call(argv)
        validate(argv)
        yield(argv[0])
      end
    end
  end
end
