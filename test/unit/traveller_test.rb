require 'test_helper'

class TravellerTest < ActiveSupport::TestCase
  test "travellers can have trips" do
    tim = travellers(:tim)
    tim.trips.push(trips(:mac2009))
    tim.trips.push(trips(:africa))

    assert_equal(2, tim.trips.size)
  end
end
