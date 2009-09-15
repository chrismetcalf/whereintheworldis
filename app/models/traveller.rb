class Traveller < ActiveRecord::Base
  # TODO Validate login
  # TODO Validate email
  # TODO Validate homepage

  has_and_belongs_to_many :trips
end
