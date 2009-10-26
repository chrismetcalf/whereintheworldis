module TripHelper
  def distance_between(from_lat, from_long, to_lat, to_long)
    return Distance.distance_in_nautical_miles(from_lat, from_long, to_lat, to_long)
  end
end
