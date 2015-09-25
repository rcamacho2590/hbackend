class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,     default: "", null: false
      t.string :full_name,     default: "", null: false
      t.string :email,     default: "", null: false

      t.timestamps
    end
  end
end
