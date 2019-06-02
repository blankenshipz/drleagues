class Model < ApplicationRecord
  has_one_attached :package

  default_scope { order(physical_score: :desc, virtual_score: :desc) }

  belongs_to :team

  validates :name, uniqueness: { scope: :team_id }
  validates :virtual_score, :physical_score, numericality: true
  validates_presence_of :name, :virtual_score, :team_id
end
