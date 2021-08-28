require_relative '../exceptions'
require_relative './validator/valid_true'
require_relative './validator/valid_false'
require_relative './validator/condition/arguments_count'
require_relative './validator/condition/empty_path'
require_relative '../../constantize'

module WebserverLogParser
  module Cli
    module Validator
      ERRORS = %w[
        ArgumentsCount
        EmptyPath
      ].freeze

      def validate(argv)
        ERRORS.each do |condition|
          "#{self.class}::Condition::#{condition}".constantize.new(argv).then do |validator|
            "#{self.class}::Valid#{validator.valid?.to_s.capitalize}".constantize.new.then do |verdict|
              verdict.validate!("WebserverLogParser::Exceptions::#{validator.error_klass}".constantize)
            end
          end
        end
      end
    end
  end
end
