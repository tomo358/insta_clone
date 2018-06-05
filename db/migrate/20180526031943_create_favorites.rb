class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :instagram_id
      t.integer :image_id

      t.timestamps
    end
  end
end
