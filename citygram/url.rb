require 'cgi'

module Citygram
  class Url
    def self.build(category_level_one, offset = 0)
      category_level = CGI.escape("CategoryLevel1 = '#{category_level_one}'")

      "https://services5.arcgis.com/54falWtcpty3V47Z/ArcGIS/rest/services/311Calls_OSC_View/FeatureServer/0/query?where=" +
      category_level +
      "&1%3D1&objectIds=" + 
      "&orderByFields=DateCreated%20DESC" +
      "&resultOffset=#{offset}&outFields=*&returnGeometry=false&f=pjson"
    end
  end
end
