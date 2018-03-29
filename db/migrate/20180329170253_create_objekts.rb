class CreateObjekts < ActiveRecord::Migration[5.1]
  def change
    create_table :objekts do |t|
      t.string :type
      t.string :name
      t.text :contents, length: 2065536 
      t.jsonb :data

      t.timestamps
    end
  end
end
