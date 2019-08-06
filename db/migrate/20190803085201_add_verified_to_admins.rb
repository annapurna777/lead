class AddVerifiedToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :everified, :boolean
    add_column :admins, :pverified, :boolean
  end
end
