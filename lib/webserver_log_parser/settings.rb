module WebserverLogParser
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
        @settings ||= {}
      end
    end
  end
end
