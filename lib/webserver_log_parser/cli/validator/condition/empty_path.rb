require_relative './base'

module WebserverLogParser
  module Cli
    module Validator
      module Condition
        class EmptyPath < Base
          def valid?
            !argv[0].empty?
          end
        end
      end
    end
  end
end
