class AddParentObjektToObjekts < ActiveRecord::Migration[5.1]
  def change
    add_column :objekts, :parent_objekt, :integer, index: true
  end
end
