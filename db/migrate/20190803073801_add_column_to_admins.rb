class AddColumnToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :otp, :integer
  end
end
