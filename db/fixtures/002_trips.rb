tim = Traveller.find_by_login('timmetcalf')
chris = Traveller.find_by_login('chrismetcalf')

Trip.seed(:name) do |t|
  t.name = "Mackinac 2009"
  t.description = "A boat race"
  t.traveller_ids = [tim.id, chris.id]
  t.destination_latitude = rand(90)
  t.destination_longitude = rand(90)
end

Trip.seed(:name) do |t|
  t.name = "South Africa Delivery"
  t.description = "A very long sail"
  t.traveller_ids = [tim.id]
  t.destination_latitude = rand(90)
  t.destination_longitude = rand(90)
end
