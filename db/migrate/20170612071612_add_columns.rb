class AddColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :homes, :houseAddress, :string
  end
end
