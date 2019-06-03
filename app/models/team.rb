class Team < ApplicationRecord
  belongs_to :league
  has_many :models
  belongs_to :top_model, class_name: 'Model', foreign_key: :top_model_id, optional: true

  validates :name, uniqueness: { scope: :league_id }
end
