class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email
      t.text :password_digest
      t.text :fullname
      t.boolean :admin
      t.text :companyname
      t.integer :maxhours
      t.integer :minhours
      t.timestamps null: false
    end
  end
end
