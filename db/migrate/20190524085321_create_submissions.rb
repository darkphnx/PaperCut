class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.string :email_address
      t.text :biography
      t.text :title
      t.text :abstract
      t.boolean :first_time_speaker
      t.integer :talk_length_in_minutes
      t.references :event, foreign_key: false

      t.timestamps
    end
  end
end
