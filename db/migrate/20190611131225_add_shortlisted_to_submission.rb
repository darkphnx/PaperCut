class AddShortlistedToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :shortlisted, :boolean, default: false
  end
end
