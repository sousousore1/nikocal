class AddMessageToStamps < ActiveRecord::Migration
  def change
    add_column :stamps, :message, :text
  end
end
