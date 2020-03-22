class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.decimal :latitude, precision:10, scale: 6, null: false
      t.decimal :longtitude, precision:10, scale: 6, null: false
      t.string :display_name, index: true, null: false
      t.jsonb :data

      t.timestamps
    end
  end
end
