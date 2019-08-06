class AddLeadTypeToLeaders < ActiveRecord::Migration[5.2]
  def change
    add_column :leaders, :lead_type, :string
    add_column :leaders, :account_number, :integer
  end
end
