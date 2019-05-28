class CreateSubmissionVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :submission_votes do |t|
      t.references :submission, foreign_key: false
      t.references :voter, foreign_key: false

      t.timestamps
    end
  end
end
