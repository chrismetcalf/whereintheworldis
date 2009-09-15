class TravellersToTrips < ActiveRecord::Migration
  def self.up
    create_table :travellers_trips, :id => false do |t|
      t.integer :traveller_id
      t.integer :trip_id
    end
  end

  def self.down
    drop_table :travellers_trips
  end
end
