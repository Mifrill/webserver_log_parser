require_relative './exceptions'

module WebserverLogParser
  class App
    def initialize(
      cli:,
      source:,
      store:,
      aggregator:,
      presenter:
    )
      self.cli = cli
      self.source = source
      self.store = store
      self.aggregator = aggregator
      self.presenter = presenter
    end

    def call(argv)
      inner_call(argv)
    rescue StandardError => e
      WebserverLogParser::Exceptions.print(e.message)
    end

    private

    def inner_call(argv)
      cli.call(argv).then do |path|
        source.call(path).then do |content|
          store.call(content).then do |scope|
            aggregator.call(scope).then do |data|
              presenter.call(data)
            end
          end
        end
      end
    end

    attr_accessor :cli,
                  :source,
                  :store,
                  :aggregator,
                  :presenter
  end
end
