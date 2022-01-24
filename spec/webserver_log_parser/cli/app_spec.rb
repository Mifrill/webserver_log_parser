require 'webserver_log_parser/cli/app'

describe WebserverLogParser::Cli::App do
  subject(:cli) do
    described_class.new
  end

  let(:argv) do
    %w[test en]
  end

  describe '#call' do
    it 'yields with file content' do
      expect { |block| cli.call(argv, &block) }.to yield_with_args('test')
    end

    context 'when validation failed' do
      context 'when 3 arguments' do
        let(:argv) do
          %w[test second-argument third-argument]
        end

        it 'raises CliArgumentsCountError' do
          expect { |block| cli.call(argv, &block) }
            .to raise_exception(WebserverLogParser::Exceptions::CliArgumentsCountError,
                                'Cannot proceed with third argument')
        end
      end

      context 'when 2 arguments' do
        let(:argv) do
          %w[test en]
        end

        it { expect { |block| cli.call(argv, &block) }.to avoid_exception }

        context 'when invalid locale' do
          let(:argv) do
            %w[test it]
          end

          it 'raises CliLocaleError' do
            expect { |block| cli.call(argv, &block) }
              .to raise_exception(WebserverLogParser::Exceptions::CliLocaleError,
                                  "We are didn't this locale")
          end
        end

        it 'stores settings' do
          fake_block = -> {}
          cli.call(argv) do
            fake_block
          end
          expect(WebserverLogParser::Settings.locale).to eq('en')
        end

        it 'rewrites locale' do
          fake_block = -> {}
          cli.call(%w[test es]) do
            fake_block
          end
          expect(WebserverLogParser::Settings.locale).to eq('es')
        end
      end

      context 'when argument is empty' do
        let(:argv) do
          ['', '']
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
