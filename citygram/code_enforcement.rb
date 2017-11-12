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

    def self.retrieve_records(offset = 0)
      url = Citygram::Url.build('Code Enforcement', offset)
      response = JSON.parse(HTTParty.get(url).body)
      records = response['features']

      features = Citygram::Feature.build(records, ALLOWED_HIERARCHIES)

      next_page_url =  Citygram::Url.build('Code Enforcement', offset + 1000) if response['exceededTransferLimit']
      [{'features' => features.compact }.to_json, next_page_url]
    end
  end
end
