require_relative '../exceptions'
require_relative './validator/valid_true'
require_relative './validator/valid_false'
require_relative './validator/condition/arguments_count'
require_relative './validator/condition/empty_path'
require_relative './validator/condition/locale'
require_relative '../../constantize'

module WebserverLogParser
  module Cli
    module Validator
      CONDITIONS = %w[
        ArgumentsCount
        EmptyPath
        Locale
      ].freeze

      def validate(argv)
        CONDITIONS.each do |condition|
          "#{self.class}::Condition::#{condition}".constantize.new(argv).then(&method(:validate!))
        end
      end

      private

      def validate!(validator)
        "#{self.class}::Valid#{validator.valid?.to_s.capitalize}".constantize.new.then do |verdict|
          verdict.call(exception_klass(validator))
        end
      end

      def exception_klass(validator)
        "WebserverLogParser::Exceptions::Cli#{validator.class.name.split('::').last}Error".constantize
      end
    end
  end
end
