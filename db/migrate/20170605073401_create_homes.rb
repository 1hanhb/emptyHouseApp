class CreateHomes < ActiveRecord::Migration[5.1]
  def change
    create_table :homes do |t|
      t.string :title
      t.string :housingType
      t.text :houseAddress
      t.string :housingDeposit
      t.string :monthlyFee
      t.text :otherDescription

      t.timestamps
    end
  end
end
