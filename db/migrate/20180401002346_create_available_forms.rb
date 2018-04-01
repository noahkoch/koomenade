class CreateAvailableForms < ActiveRecord::Migration[5.1]
  def change
    create_table :available_forms do |t|
      t.references :document, foreign_key: true
      t.string :table_name
      t.jsonb :fields

      t.timestamps
    end
  end
end
