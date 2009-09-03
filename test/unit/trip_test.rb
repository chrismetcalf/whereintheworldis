require 'test_helper'

class TripTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "trips can contain pings" do
    africa = trips(:africa)
    africa.pings.push(pings(:africa_one))
    africa.pings.push(pings(:africa_two))
    africa.pings.push(pings(:africa_three))

    assert_equal(3, africa.pings.size)
  end
end
