class AddAvailableSlotsToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :available_slots, :integer
  end
end
