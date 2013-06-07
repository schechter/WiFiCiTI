class CreateHotspots < ActiveRecord::Migration
  def change
    create_table :hotspots do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :name
      t.string :street
      t.string :city
      t.string :zip
      t.string :phone
      t.string :fee
      t.string :url

      t.timestamps
    end
  end
end
