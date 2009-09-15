class CreateTravellers < ActiveRecord::Migration
  def self.up
    create_table :travellers do |t|
      t.string :login
      t.string :name
      t.string :email
      t.string :homepage
      t.text :bio

      t.string :pop_host
      t.string :pop_login
      t.string :pop_password

      t.timestamps
    end
  end

  def self.down
    drop_table :travellers
  end
end
