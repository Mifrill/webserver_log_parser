require_relative './base'

module WebserverLogParser
  module Cli
    module Validator
      module Condition
        class Locale < Base
          LOCALES = %w[en es].freeze

          def valid?
            LOCALES.include?(argv[1])
          end
        end
      end
    end
  end
end
