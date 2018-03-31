class ChangeParentObjekColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :objekts, :parent_objekt, :parent_objekt_id
  end
end
