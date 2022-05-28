class ChangeTypeDurationTimeInEventColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :duration_time, :float
  end
end
