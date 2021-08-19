module WebserverLogParser
  module Aggregator
    class App
      def call(scope)
        [
          total_pages_views(scope),
          unique_pages_views(scope)
        ]
      end

      private

      def total_pages_views(scope)
        scope.total_pages_views.order_by_most_views.to_a
      end

      def unique_pages_views(scope)
        scope.unique_pages_views.order_by_most_views.to_a
      end
    end
  end
end
