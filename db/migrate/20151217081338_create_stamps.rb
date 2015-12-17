class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.date :target_date
      t.integer :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
