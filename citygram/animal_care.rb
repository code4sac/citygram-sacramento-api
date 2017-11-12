require_relative './url'
require_relative './feature'

module Citygram
  class AnimalCare
    def self.retrieve_records(offset = 0)
      url = Citygram::Url.build('Animal care', offset)
      response = JSON.parse(HTTParty.get(url).body)
      records = response['features']

      features = Citygram::Feature.build(records)

      next_page_url =  Citygram::Url.build('Animal care', offset + 1000) if response['exceededTransferLimit']

      [{'features' => features.compact }.to_json, next_page_url]
    end
  end
end
