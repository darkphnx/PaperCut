class AddWeightToSubmissionVote < ActiveRecord::Migration[5.2]
  def change
    add_column :submission_votes, :weight, :integer, default: 0
  end
end
