class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :date_event
      t.time :duration_time
      t.string :place
      t.string :min_number_of_joiners
      t.string :max_number_of_joiners
      t.float :price
      t.integer :min_age

      t.timestamps
    end
  end
end
