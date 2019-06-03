class AddTopModelToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :top_model_id, :integer, index: true
    add_foreign_key :teams, :models, column: :top_model_id
  end
end
