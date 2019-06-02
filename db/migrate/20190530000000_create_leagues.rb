class CreateLeagues < ActiveRecord::Migration[6.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.datetime :submission_deadline

      t.timestamps
    end
  end
end
