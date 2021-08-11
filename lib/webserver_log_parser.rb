module WebserverLogParser
  class << self
    def load
      %w[
        lib/webserver_log_parser/app
        lib/webserver_log_parser/cli/app
        lib/webserver_log_parser/source/app
        lib/webserver_log_parser/store/app
        lib/webserver_log_parser/aggregator/app
        lib/webserver_log_parser/presenter/app
      ].each do |path|
        require File.expand_path(path)
      end
    end

    def run(args)
      WebserverLogParser::App.new(
        cli: WebserverLogParser::Cli::App.new,
        source: WebserverLogParser::Source::App.new,
        store: WebserverLogParser::Store::App.new,
        aggregator: WebserverLogParser::Aggregator::App.new,
        presenter: WebserverLogParser::Presenter::App.new
      ).call(args)
    end
  end
end
