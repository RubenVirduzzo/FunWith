class RemoveEventsTagsJoinTable < ActiveRecord::Migration[7.0]
  def change
    drop_join_table :events, :tags
  end
end
