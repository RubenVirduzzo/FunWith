class ChangeEventColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :min_number_of_joiners, :integer
    change_column :events, :max_number_of_joiners, :integer
  end
end
