class AddCoordinatesToYachts < ActiveRecord::Migration[6.1]
  def change
    add_column :yachts, :latitude, :float
    add_column :yachts, :longitude, :float
  end
end
