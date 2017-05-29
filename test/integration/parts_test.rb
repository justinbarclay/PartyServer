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

    puts response.body
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
    part = JSON.parse(response.body)['part']

    assert @part.name.eql? part['name']

    assert @part.room.eql? part['room']
  end

  test 'get a part with the wrong ID' do
    id = @part.id+1
    get "/api/parts/#{id}", headers: authenticated_header

    assert_response 404
    assert_not JSON.parse(response.body)['success']
  end

  test 'get all parts' do
    get "/api/parts", headers: authenticated_header
    
    assert_response 200
    assert JSON.parse(response.body)['success']
    assert JSON.parse(response.body)['parts'].size == 2
    
  end

  test 'post a part with units' do
    post '/api/parts', headers: authenticated_header, params: {
           part: {
             unit_parts_attributes: [{unit_attributes: {name: 'U32'}}, {unit_attributes: {name: 'U89'}}],
             name: :gasket,
             count: 20,
             room: 'Mechanical Room',
             shelf: 'A4'
           }}
    puts Unit.all.inspect
    puts Part.last.inspect
    puts UnitPart.all.inspect
    assert_response 201
    assert JSON.parse(response.body)['success']
  end
    
end
