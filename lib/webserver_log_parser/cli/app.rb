require_relative './validator'

module WebserverLogParser
  module Cli
    class App
      include Validator

      def call(argv)
        yield(validate(argv))
      end
    end
  end
end