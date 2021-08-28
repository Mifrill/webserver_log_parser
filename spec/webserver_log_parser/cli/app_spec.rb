require 'webserver_log_parser/cli/app'

describe WebserverLogParser::Cli::App do
  subject(:cli) do
    described_class.new
  end

  let(:argv) do
    ['test']
  end

  describe '#call' do
    it 'yields with file content' do
      expect { |block| cli.call(argv, &block) }.to yield_with_args('test')
    end

    context 'when validation failed' do
      context 'when 2 arguments' do
        let(:argv) do
          %w[test second-argument]
        end

        it 'raises CliArgumentsCountError' do
          expect { |block| cli.call(argv, &block) }
            .to raise_exception(WebserverLogParser::Exceptions::CliArgumentsCountError,
                                'Cannot proceed with second argument')
        end
      end

      context 'when argument is empty' do
        let(:argv) do
          ['']
        end

        it 'raises CliEmptyPathError' do
          expect { |block| cli.call(argv, &block) }
            .to raise_exception(WebserverLogParser::Exceptions::CliEmptyPathError,
                                'Path to source is empty | should be as first argument')
        end
      end
    end
  end
end
