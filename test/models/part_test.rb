require 'test_helper'

class PartTest < ActiveSupport::TestCase
  def setup
    @part = Part.new(name: "Gasket", count: 203, room: "Mechanical Room", shelf: "A3")
  end

  test "parts can be saved" do
    assert @part.valid?
    assert @part.save
  end

  test "parts need names" do
    @part.name = ""

    assert_not @part.valid?
  end

  test "parts count need to be integer" do
    @part.count = 3.1

    assert_not @part.valid?

    @part.count = :hello
    assert_not @part.save
  end

  test "part needs a room" do
    @part.room = ""

    assert_not @part.valid?
  end

  test "part doesn't need a shelf" do
    @part.shelf = ""

    assert @part.valid?
  end
end
