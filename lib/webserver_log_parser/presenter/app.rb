require_relative './console'
require_relative '../cli/settings'

module WebserverLogParser
  module Presenter
    class App
      GLOSSARY = {
        en: {
          visit: 'visit',
          unique: 'unique',
          average: 'average'
        },
        es: {
          visit: 'visita',
          unique: 'única',
          average: 'promedio'
        }
      }.freeze

      def initialize(
        output: WebserverLogParser::Presenter::Console.new,
        settings: WebserverLogParser::Cli::Settings
      )
        self.output = output
        self.settings = settings
      end

      def call(data)
        total_pages_views, unique_pages_views, average_pages_views = *data
        {
          total_pages_views => glossary(:visit),
          unique_pages_views => "#{glossary(:unique)} #{glossary(:visit)}",
          average_pages_views => "#{glossary(:average)} #{glossary(:visit)}"
        }.each { |rows, text| output.call(rows: rows, text: text) }
      end

      private

      attr_accessor :output, :settings

      def glossary(word)
        GLOSSARY[settings.locale.to_sym][word]
      end
    end
  end
end
