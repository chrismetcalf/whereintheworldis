Trip.all.each do |trip|
  puts "Adding pings to #{trip.name}"

  lat = rand(90)
  long = rand(90)
  time = Time.now

  50.times do
    Ping.seed(:trip_id, :when_timestamp,
              :latitude, :longitude) do |p|
      p.when_timestamp = time
      p.latitude = lat
      p.longitude = long
      p.message = `fortune`
      p.trip_id = trip.id
    end

    lat += rand(10)
    long += rand(10)
    time += rand(48).hours
  end
end
