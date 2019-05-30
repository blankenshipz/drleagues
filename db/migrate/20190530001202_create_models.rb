class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :models do |t|
      t.references :team, null: false, foreign_key: true
      t.float :virtual_score
      t.float :physical_score
      t.text :path

      t.timestamps
    end
  end
end
