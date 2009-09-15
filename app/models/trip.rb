class Trip < ActiveRecord::Base
  has_and_belongs_to_many :traveller
  has_many :pings
end
