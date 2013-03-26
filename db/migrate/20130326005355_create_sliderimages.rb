class CreateSliderimages < ActiveRecord::Migration
  def change
    create_table :sliderimages do |t|
      t.string :image_name
      t.string :image_link

      t.timestamps
    end
  end
end
