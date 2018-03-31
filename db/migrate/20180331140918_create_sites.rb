class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :key
      t.references :user, foreign_key: true
      t.text :contents

      t.timestamps
    end
  end
end
