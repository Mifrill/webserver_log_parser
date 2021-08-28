module WebserverLogParser
  module Cli
    module Validator
      module Condition
        class Base
          def initialize(argv, &block)
            self.argv = argv
            self.validate = block
          end

          def valid?
            raise NotImplementedError, __method__
          end

          def error_klass
            raise NotImplementedError, __method__
          end

          private

          attr_accessor :argv, :validate
        end
      end
    end
  end
end
