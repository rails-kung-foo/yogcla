class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :courses, :end, :ending
  end
end
