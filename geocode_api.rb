require 'httparty'
require 'json'

require 'pry'

class GeoCodeAPI

  def initialize
    @base_url = 'http://api.openweathermap.org/geo/1.0/'
    @api_key = 'f897a99d971b5eef57be6fafa0d83239'
  end

  def get_coordinates(list:)
    list.map do |location|
      if location.match?(/\d+/)
        get_postal(location)
      else
        get_direct(location.downcase.gsub(' ', '').split(',')[0..1].join(',') + ',us')
      end
    end
  end

  :private

  def get_direct(location)
    url = @base_url + 'direct?q=%s&limit=%d&appid=' + @api_key
    result = parse_response(HTTParty.get(sprintf(url, location, 1)))
  end

  def get_postal(zip)
    url = @base_url + 'zip?zip=%s&appid=' + @api_key
    result = parse_response(HTTParty.get(sprintf(url, zip, 1)))
  end

  def parse_response(response)
    result = JSON.parse(response.body)
    result = result.first if result.is_a? Array
    text = "#{result['name']}, #{result['state']}, #{result['country']} -> latitude: #{result['lat']}, longitude: #{result['lon']}"
    text.gsub(', ,', ',')
  end

end
