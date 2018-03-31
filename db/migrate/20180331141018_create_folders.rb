class CreateFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :folders do |t|
      t.references :site, foreign_key: true
      t.references :folder, foreign_key: true
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
