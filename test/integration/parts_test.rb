require 'test_helper'

class PartsTest < ActionDispatch::IntegrationTest
  def setup
    @part = parts(:one)
  end

  test "can post to parts" do

    post '/api/parts', headers: authenticated_header, params: {
           part: {
             name: :gasket,
             count: 20,
             room: 'Mechanical Room',
             shelf: 'A3' } }

    assert_response 201
    assert JSON.parse(response.body)['success']
  end
end
