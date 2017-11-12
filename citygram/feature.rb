module Citygram
  class Feature
    THREE_DAYS_AGO = (Time.now.to_i - (3*24*60*60)) * 1000

    def self.build(records, filter_list=[])
      records.map do |record|
        lat = record['attributes']['Latitude'].to_f
        lng = record['attributes']['Longitude'].to_f
        created_at = record['attributes']['DateCreated'].to_i

        next if lat == 0.0 || lng == 0.0
        next if created_at < THREE_DAYS_AGO

        unless filter_list.empty?
          category_hierarchy = record['attributes']['CategoryHierarchy']
          next unless filter_list.include?(category_hierarchy)
        end

        title = record['attributes']['CategoryHierarchy']
        {
          'id'          => record['attributes']['GlobalID'],
          'type'        => 'Feature',
          'properties'  => record.merge('title' => title),
          'geometry'    => {
            'type'        => 'Point',
            'coordinates' =>  [lng, lat]
          }
        }
      end.compact
    end
  end
end
