class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.text :stil

      t.timestamps
    end
  end
end
