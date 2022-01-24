module WebserverLogParser
  module Cli
    class Settings
      class << self
        def locale
          settings[:locale]
        end

        def locale=(locale)
          settings[:locale] = locale
        end

        private

        def settings
          @settings ||= {
            locale: 'en'
          }
        end
      end
    end
  end
end
