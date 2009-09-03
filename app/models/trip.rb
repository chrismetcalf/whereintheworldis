class Trip < ActiveRecord::Base
  belongs_to :traveller
  has_many :pings
end
