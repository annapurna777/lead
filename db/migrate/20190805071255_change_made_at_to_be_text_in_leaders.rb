class ChangeMadeAtToBeTextInLeaders < ActiveRecord::Migration[5.2]
  def up
    change_column :leaders, :made_at, :text
  end

  def down
    change_column :leaders, :made_at, :integer
  end
end
