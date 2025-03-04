When(/^the (\w*), (\w*) and (\w*) are given$/) do |city, state, country|
  @response = @api.get_direct(location: "#{city},#{state},#{country}")
end

Then(/^the response contains latitude and longitude$/) do
  response = JSON.parse(@response.body)
  response = response.first if response.is_a? Array
  expect(response['lat']).to_not be_nil
  expect(response['lon']).to_not be_nil
end

When(/^the (\w*) and (\w*) are given without a country$/) do |city, state|
   @response = @api.get_direct(location: "#{city},#{state}")
end

Then(/^the response does not contain latitude and longitude$/) do
  response = JSON.parse(@response.body)
  response = response.first if response.is_a? Array
  expect(response).to be_nil
end

When(/^the (\d+) is given$/) do |zip_code|
  @response = @api.get_postal(zip: zip_code)
end

When(/^an invalid zip code is given$/) do
  @response = @api.get_postal(zip: 'ABCDE')
end

Then(/^the response returns a 404 error$/) do
  response = JSON.parse(@response.body)
  expect(response['cod']).to eq('404')
  expect(response['message']).to eq('not found')
end

When(/^a direct request is made without an API key$/) do
  @response = @api.get_direct(location: 'Portland,OR', api_key: '')
end

When(/^a postal code request is made without an API key$/) do
  @response = @api.get_postal(zip: 98601, api_key: '')
end

Then(/^the response returns a 401 error$/) do
  response = JSON.parse(@response.body)
  expect(response['cod']).to eq(401)
end
