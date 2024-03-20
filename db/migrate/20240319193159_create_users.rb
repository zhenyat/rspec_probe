class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name,  null: false
      t.string :email,      null: false, index: {unique: true}
      t.string :phone,      null: false, index: {unique: true}
      t.integer :role,      null: false, limit: 1, default: 0

      t.timestamps
    end
  end
end
