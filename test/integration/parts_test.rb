require 'test_helper'

class PartsTest < ActionDispatch::IntegrationTest
  def setup
    @part = parts(:one)
    @part.save
  end

  test 'can post to parts' do

    post '/api/parts', headers: authenticated_header, params: {
           part: {
             name: :gasket,
             count: 20,
             room: 'Mechanical Room',
             shelf: 'A3' } }

    assert_response 201
    assert JSON.parse(response.body)['success']
  end

  test 'parts json missing data' do
    post '/api/parts', headers: authenticated_header, params: {
           part: {
             count: 'thing',
             shelf: 'A3' } }

    assert_response 500
    assert_not JSON.parse(response.body)['success']
    assert JSON.parse(response.body)['errors'].size == 4
  end

  test 'get a part' do
    id = @part.id
    get "/api/parts/#{id}", headers: authenticated_header

    assert_response 200
    assert JSON.parse(response.body)['success']
  end
end
