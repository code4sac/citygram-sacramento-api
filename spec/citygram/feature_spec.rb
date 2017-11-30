require 'securerandom'
require File.expand_path '../../spec_helper.rb', __FILE__
require_relative '../../citygram/feature.rb'

describe Citygram::Feature do
  describe '.build' do
    let(:record) do
      { 
        'attributes' => {
          'GlobalID'          =>  SecureRandom.uuid,
          'Latitude'          =>  '36.127',
          'Longitude'         =>  '36.127',
          'CategoryHierarchy' =>  'HAM',
          'DateCreated'       =>  Citygram::Feature::THREE_DAYS_AGO
        }
      }
    end

    let(:built_records) do
      [
        {
          'id'            =>  record['attributes']['GlobalID'],
          'type'          =>  'Feature',
          'properties'    => {
            'attributes'  => {
              'GlobalID'          =>  record['attributes']['GlobalID'],
              'Latitude'          =>  '36.127',
              'Longitude'         =>  '36.127',
              'CategoryHierarchy' =>  'HAM',
              'DateCreated'       =>  Citygram::Feature::THREE_DAYS_AGO
            },
            'title' =>  'HAM'
          },
          'geometry'  => {
            'type'        =>  'Point',
            'coordinates' =>  [36.127, 36.127]
          }
        }
      ]
    end

    context 'lat is not present in record' do
      it 'will filter out the record' do
        record['attributes']['Latitude'] = nil

        expect(described_class.build([record])).to eq([])
      end
    end

    context 'lng is not present in record' do
      it 'will filter out the record' do
        record['attributes']['Longitude'] = nil

        expect(described_class.build([record])).to eq([])
      end
    end

    context 'record is older than 3 days in record' do
      it 'will filter out the record' do
        record['attributes']['DateCreated'] = DateTime.new(1985,6,16).strftime('%Q')

        expect(described_class.build([record])).to eq([])
      end
    end

    context 'filter list is passed in' do
      context 'record does not have a filterable field' do
        it 'will filter out the record' do
          expect(described_class.build([record], ['SPAM'])).to eq([])
        end
      end

      context 'record does have a filterable field' do
        it 'will filter keep the record' do
          expect(described_class.build([record], ['HAM'])).to eq(built_records)
        end
      end
    end

    context 'filter list is not passed in' do
      it 'will filter keep the record' do
        expect(described_class.build([record])).to eq(built_records)
      end
    end
  end
end