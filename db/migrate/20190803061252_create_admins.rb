class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.integer :mobile_number
      t.string :email
      t.string :password_digest
      t.string :user_name
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
