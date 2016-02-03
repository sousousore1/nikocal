class AddColumnToStamp < ActiveRecord::Migration
  def change
    add_column :stamps, :one_chance, :boolean
  end
end
