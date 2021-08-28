module WebserverLogParser
  module Cli
    module Validator
      module Condition
        class Base
          def initialize(argv)
            self.argv = argv
          end

          def valid?
            raise NotImplementedError, __method__
          end

          def error_klass
            raise NotImplementedError, __method__
          end

          private

          attr_accessor :argv
        end
      end
    end
  end
end
