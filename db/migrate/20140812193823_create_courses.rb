class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.belongs_to :studio, index: true
      t.belongs_to :style, index: true
      t.string :start
      t.string :end
      t.string :weekday

      t.timestamps
    end
  end
end
