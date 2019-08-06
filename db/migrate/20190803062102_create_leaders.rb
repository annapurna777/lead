class CreateLeaders < ActiveRecord::Migration[5.2]
  def change
    create_table :leaders do |t|
      t.integer :type
      t.string :name
      t.string :docf
      t.string :docb
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
