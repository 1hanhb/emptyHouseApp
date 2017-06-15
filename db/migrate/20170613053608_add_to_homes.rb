class AddToHomes < ActiveRecord::Migration[5.1]
  def change
    add_column :homes, :lng, :string
    add_column :homes, :lat, :string
  end
end
