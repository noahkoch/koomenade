class CreateKqlDataStores < ActiveRecord::Migration[5.1]
  def change
    create_table :kql_data_stores do |t|
      t.jsonb :structure, default: {}
      t.references :user, foreign_key: true
      t.string :name
      t.jsonb :values, default: {}

      t.timestamps
    end
  end
end
