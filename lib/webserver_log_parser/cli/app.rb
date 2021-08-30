require_relative './validator'
require_relative './converter'

module WebserverLogParser
  module Cli
    class App
      include Validator

      def initialize(converter: Converter.new)
        self.converter = converter
      end

      def call(argv, &block)
        validate(argv)
        converter.call(argv).then(&block)
      end

      private

      attr_accessor :converter
    end
  end
end
