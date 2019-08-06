class RemoveTypeFromLeaders < ActiveRecord::Migration[5.2]
  def change
    remove_column :leaders, :type, :integer
  end
end
