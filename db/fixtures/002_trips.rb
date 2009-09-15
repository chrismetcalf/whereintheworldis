tim = Traveller.find_by_login('timmetcalf')
chris = Traveller.find_by_login('chrismetcalf')

Trip.seed(:name) do |t|
  t.name = "Mackinac 2009"
  t.description = "A boat race"
  t.traveller_ids = [tim.id, chris.id]
end

Trip.seed(:name) do |t|
  t.name = "South Africa Delivery"
  t.description = "A very long sail"
  t.traveller_ids = [tim.id]
end
