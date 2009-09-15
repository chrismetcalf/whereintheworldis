Traveller.seed(:login) do |t|
  t.login = "timmetcalf"
  t.name = "Tim Metcalf"
  t.email = "tim_metcalf@example.com"
  t.homepage = "http://timmetcalf.net"
  t.bio = "Just a guy"
end

Traveller.seed(:login) do |t|
  t.login = "chrismetcalf"
  t.name = "Chris Metcalf"
  t.email = "chris@example.com"
  t.homepage = "http://chrismetcalf.net"
  t.bio = "Just a guy's kid"
end
