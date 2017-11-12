require_relative './url'

module Citygram
  class Sewer

    ALLOWED_HIERARCHIES = [
      'Sewer : Manhole Overflowing',
      'Sewer : Exposed Line',
      'Sewer : Hazmat'
    ].freeze

    def self.retrieve_records(offset = 0)
      url = Citygram::Url.build('Sewer', offset)
      response = JSON.parse(HTTParty.get(url).body)
      records = response['features']

      features = Citygram::Feature.build(records, ALLOWED_HIERARCHIES)

      next_page_url =  Citygram::Url.build('Sewer', offset + 1000) if response['exceededTransferLimit']
      [{'features' => features.compact }.to_json, next_page_url]
    end
  end
end
