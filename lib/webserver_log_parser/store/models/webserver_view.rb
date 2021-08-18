module WebserverLogParser
  module Store
    module Models
      class WebserverView < Sequel::Model
        dataset_module do
          def total_pages_views
            group_and_count(:route)
          end

          def unique_pages_views
            group(:route).select do |row|
              [:route, row.count(:ip).distinct.as(:count)]
            end
          end

          def average_page_views
            group(:route).select do |row|
              [:route, (row.count(:ip) / row.count(:ip).distinct.cast(Float)).as(:count)]
            end
          end

          def order_by_most_views
            reverse_order(:count)
          end
        end

        def validate
          super
          errors.add(:route, "can't be empty") if route && route.empty?
          errors.add(:ip, "can't be empty") if ip && ip.empty?
        end
      end
    end
  end
end
