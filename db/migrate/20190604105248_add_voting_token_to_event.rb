class AddVotingTokenToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :voting_token, :string
  end
end
