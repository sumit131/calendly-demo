class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :address
      t.string :cell_phone_number
      t.string :home_phone_number
      t.string :street_address
      t.string :island
      t.string :gender
      t.date :date_of_birth

      t.timestamps
    end
  end
end
