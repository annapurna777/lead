class AddColumnToLeaders < ActiveRecord::Migration[5.2]
  def change
    add_column :leaders, :made_by, :integer
    add_column :leaders, :made_at, :datetime
  end
end
