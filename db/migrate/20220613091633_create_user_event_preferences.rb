class CreateUserEventPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :user_event_preferences do |t|
      t.integer :user_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
