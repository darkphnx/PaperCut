class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :cfp_open_until
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
