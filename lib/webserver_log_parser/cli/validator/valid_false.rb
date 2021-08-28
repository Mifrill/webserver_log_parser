module WebserverLogParser
  module Cli
    module Validator
      class ValidFalse
        def call(error)
          raise(error)
        end
      end
    end
  end
end
