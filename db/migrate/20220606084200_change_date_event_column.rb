class ChangeDateEventColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :date_event, :datetime
  end
end
