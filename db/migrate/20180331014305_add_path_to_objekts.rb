class AddPathToObjekts < ActiveRecord::Migration[5.1]
  def change
    add_column :objekts, :path, :string, index: :true
  end
end
