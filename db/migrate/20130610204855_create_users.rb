class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.float :latitude
      t.float :longitude
      t.string :location

      t.timestamps
    end
  end
end
