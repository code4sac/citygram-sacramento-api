require_relative './url'

module Citygram
  class Homeless
    ALLOWED_HIERARCHIES = [
      'Other : Homeless Camp'
    ].freeze

    def self.retrieve_records(offset = 0)
      url = Citygram::Url.build('Other', offset)
      response = JSON.parse(HTTParty.get(url).body)
      records = response['features']

      features = Citygram::Feature.build(records, ALLOWED_HIERARCHIES)

      next_page_url =  Citygram::Url.build('Animal care', offset + 1000) if response['exceededTransferLimit']
      [{'features' => features.compact }.to_json, next_page_url]
    end
  end
end
