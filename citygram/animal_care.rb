require_relative './url'

module Citygram
  class AnimalCare
    def self.build_features(records)
      one_week_ago = (Time.now.to_i - (7*24*60*60)) * 1000

      records.map do |record|
        lat = record['attributes']['Latitude'].to_f
        lng = record['attributes']['Longitude'].to_f
        created_at = record['attributes']['DateCreated'].to_i

        next if lat == 0.0 || lng == 0.0
        next if created_at < one_week_ago

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
      end
    end

    def self.retrieve_records(offset = 0)
      url = Citygram::Url.build('Animal care', offset)
      response = JSON.parse(HTTParty.get(url).body)
      records = response['features']

      features = build_features(records)

      next_page_url =  Citygram::Url.build('Animal care', offset + 1000) if response['exceededTransferLimit']

      [{'features' => features.compact }.to_json, next_page_url]
    end
  end
end
