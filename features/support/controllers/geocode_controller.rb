require 'httparty'

class GeoCodeController

  def initialize
    @base_url = 'http://api.openweathermap.org/geo/1.0/'
    @api_key = 'f897a99d971b5eef57be6fafa0d83239'
  end

  def get_direct(location:, api_key: @api_key)
    url = @base_url + 'direct?q=%s&limit=%d&appid=' + api_key
    result = HTTParty.get(sprintf(url, location, 1))
  end

  def get_postal(zip:, api_key: @api_key)
    url = @base_url + 'zip?zip=%s&appid=' + api_key
    result = HTTParty.get(sprintf(url, zip, 1))
  end

end
