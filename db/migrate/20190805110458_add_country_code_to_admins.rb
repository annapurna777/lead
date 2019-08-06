class AddCountryCodeToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :country_code, :integer
  end
end
