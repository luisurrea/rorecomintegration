class CreateStaticpages < ActiveRecord::Migration
  def change
    create_table :staticpages do |t|
      t.string            :name,                  :null => false
      t.text              :description

      t.timestamps
    end
  end
end
