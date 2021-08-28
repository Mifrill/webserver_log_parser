module WebserverLogParser
  module Cli
    module Validator
      class ValidFalse
        def validate!(error)
          raise error
        end
      end
    end
  end
end
