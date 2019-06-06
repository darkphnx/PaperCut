class AddCommentToSubmissionVote < ActiveRecord::Migration[5.2]
  def change
    add_column :submission_votes, :comment, :text
  end
end
