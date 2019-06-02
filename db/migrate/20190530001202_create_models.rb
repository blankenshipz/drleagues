class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :models do |t|
      t.references :team, null: false, foreign_key: true
      t.float :virtual_score, null: false
      t.float :physical_score, null: false, default: 0.0
      t.text :name, null: false

      t.timestamps
    end

    add_index :models, [:name, :team_id], unique: true
  end
end
