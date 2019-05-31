class AddEventDateToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :date_of_event, :datetime
  end
end
