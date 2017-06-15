class AddToHomesDetailedAddress2 < ActiveRecord::Migration[5.1]
  def change
    add_column :homes, :detailedAddress, :string
  end
end
