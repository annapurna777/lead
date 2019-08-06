class CreateNominees < ActiveRecord::Migration[5.2]
  def change
    create_table :nominees do |t|
      t.string :name
      t.integer :age
      t.references :leader, foreign_key: true

      t.timestamps
    end
  end
end
