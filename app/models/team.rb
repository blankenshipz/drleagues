class Team < ApplicationRecord
  belongs_to :league

  validates :name, uniqueness: { scope: :league_id }
end
