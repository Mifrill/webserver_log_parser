require 'webserver_log_parser/cli/validator/condition/base'

describe WebserverLogParser::Cli::Validator::Condition::Base do
  subject(:inherited) { Class.new(described_class) }

  describe '#valid?' do
    it { expect { inherited.new(anything).valid? }.to raise_exception(NotImplementedError) }
  end
end
