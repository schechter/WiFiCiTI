class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :hotspot_id
      t.integer :user_id
      t.integer :speed
      t.integer :reliability
      t.integer :accessibility
      t.integer :power
      t.integer :noise_level
      t.text :comments, limit: nil

      t.timestamps
    end
  end
end
