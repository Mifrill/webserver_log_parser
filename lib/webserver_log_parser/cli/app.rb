require_relative './validator'
require_relative './converter'
require_relative '../settings'

module WebserverLogParser
  module Cli
    class App
      include Validator

      def initialize(
        converter: Converter.new,
        settings: WebserverLogParser::Settings
      )
        self.converter = converter
        self.settings = settings
      end

      def call(argv, &block)
        validate(argv)
        setup_locale(argv)
        converter.call(argv).then(&block)
      end

      private

      attr_accessor :converter, :settings

      def setup_locale(argv)
        settings.locale = argv[1]
      end
    end
  end
end
