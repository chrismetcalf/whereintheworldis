class CreateTrips < ActiveRecord::Migration
  def self.up
    create_table :trips do |t|
      t.string :name
      t.text :description
      t.integer :traveller_id

      t.timestamps
    end
  end

  def self.down
    drop_table :trips
  end
end
