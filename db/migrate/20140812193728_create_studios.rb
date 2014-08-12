class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.text :address
      t.text :url

      t.timestamps
    end
  end
end
