require_relative './url'

module Citygram
    class CodeEnforcement

    ALLOWED_HIERARCHIES = [
    'Code Enforcement : Environmental : Complaint',
    'Code Enforcement : Environmental : Pest',
    'Code Enforcement : Environmental : Stagnant Water',
    'Code Enforcement : Vehicle On-Street : Potential   Hazard',
    'Code Enforcement : Work Without Permit'
    ].freeze

    def self.build_features(records)
      records.map do |record|
        lat = record['attributes']['Latitude'].to_f
        lng = record['attributes']['Longitude'].to_f
        next if lat == 0.0 || lng == 0.0

        category_hierarchy = record['attributes']['CategoryHierarchy']
        next unless ALLOWED_HIERARCHIES.include?(category_hierarchy)

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
        url = Citygram::Url.build('Code Enforcement', 0)
      response = JSON.parse(HTTParty.get(url).body)
      records = response['features']

      features = build_features(records)

        next_page_url =  Citygram::Url.build('Code Enforcement', offset + 1000) if response['exceededTransferLimit']
      [{'features' => features.compact }.to_json, next_page_url]
    end
  end
end
