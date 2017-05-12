require 'test_helper'

class PartHistoryTest < ActiveSupport::TestCase
  def setup
    user = users(:one)
    part = parts(:one)
    @part_history = PartHistory.new(user: user, part: part, change: 100)
  end

  test "PartHistory can be saved" do
    assert @part_history.valid?
    assert @part_history.save
  end

  test "PartHistory needs a user" do
    @part_history.user = nil
    assert_not @part_history.valid?
  end

  test "PartHistory needs a part" do
    @part_history.part = nil
    assert_not @part_history.valid?
  end

  test "PartHistory change needs to be an integer" do
    @part_history.change = "here"
    assert_not @part_history.valid?

    @part_history.change = 3.1
    assert_not @part_history.valid?
  end
end
