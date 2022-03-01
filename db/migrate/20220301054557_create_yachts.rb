class CreateYachts < ActiveRecord::Migration[6.1]
  def change
    create_table :yachts do |t|
      t.string :name
      t.float :price
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
