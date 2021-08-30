require_relative './validator'
require_relative './converter'

module WebserverLogParser
  module Cli
    class App
      include Validator

      def call(argv, converter: Converter.new, &block)
        validate(argv)
        converter.call(argv).then(&block)
      end
    end
  end
end
