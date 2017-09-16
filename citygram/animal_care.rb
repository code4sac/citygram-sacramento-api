module Citygram
  class AnimalCare
    def self.retrieve_records(offset = 0)
      response = HTTParty.get("https://services5.arcgis.com/54falWtcpty3V47Z/ArcGIS/rest/services/311Calls_OSC_View/FeatureServer/0/query?where=CategoryLevel1+%3D+%27Animal+care%27&1%3D1&objectIds=&resultOffset=#{offset}&outFields=*&returnGeometry=true&f=pjson")
      records = JSON.parse(response.body)['features']

      features = records.map do |record|
        lat = record['attributes']['Latitude'].to_f
        lng = record['attributes']['Longitude'].to_f
        next if lat == 0.0 || lng == 0.0

        title = "Animal Care Holder Title"
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

      {'features' => features }.compact.to_json
    end
  end
end
