class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.references :league, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end

    add_index :teams, [:name, :league_id], unique: true
  end
end
