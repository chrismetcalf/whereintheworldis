class CreatePings < ActiveRecord::Migration
  def self.up
    create_table :pings do |t|
      t.timestamp :when
      t.decimal :latitude
      t.decimal :longitude
      t.text :message
      t.integer :trip_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pings
  end
end
