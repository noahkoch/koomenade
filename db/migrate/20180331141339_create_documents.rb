class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.text :contents
      t.references :site, foreign_key: true
      t.references :user, foreign_key: true
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
