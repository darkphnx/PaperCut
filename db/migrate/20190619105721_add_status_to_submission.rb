class AddStatusToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :shortlist_status, :string
  end
end
