class AddWebsiteToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :website, :string
  end
end
