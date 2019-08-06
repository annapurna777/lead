class ChangeMobileNumberTypeInLeaders < ActiveRecord::Migration[5.2]
 def up
    change_column :admins, :mobile_number, :string
  end

  def down
    change_column :admins, :mobile_number, :integer
  end
end
