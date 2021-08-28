require_relative './base'

module WebserverLogParser
  module Cli
    module Validator
      module Condition
        class ArgumentsCount < Base
          def valid?
            argv.size == 1
          end
        end
      end
    end
  end
end
