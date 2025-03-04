require 'httparty'
require_relative 'geocode_api.rb'

api = GeoCodeAPI.new

puts api.get_coordinates(list: ARGV)
