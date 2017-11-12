require_relative './url'
require_relative './feature'

module Citygram
  class UrbanForestry

    ALLOWED_HIERARCHIES = [
      'Urban Forestry : Inspection'
    ].freeze

    def self.retrieve_records(offset = 0)
      url = Citygram::Url.build('Urban Forestry', 0)
      response = JSON.parse(HTTParty.get(url).body)
      records = response['features']

      features = Citygram::Feature.build(records, ALLOWED_HIERARCHIES)

      next_page_url =  Citygram::Url.build('Urban Forestry', offset + 1000) if response['exceededTransferLimit']
      [{'features' => features.compact }.to_json, next_page_url]
    end
  end
end
