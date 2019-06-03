class League < ApplicationRecord
  has_many :teams

  def teams_by_top_model
    teams.includes(:top_model).sort_by do |t|
      if t.top_model.present?
        physical_score = t.top_model.physical_score
        virtual_score = t.top_model.virtual_score
      else
        physical_score = nil
        virtual_score = nil
      end

      [
        physical_score.present? ? physical_score : Float::INFINITY,
        virtual_score.present? ? virtual_score : Float::INFINITY
      ]
    end
  end
end
