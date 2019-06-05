class Model < ApplicationRecord
  after_save :update_team_top_model, :update_package_name
  has_one_attached :package

  default_scope { order(physical_score: :asc, virtual_score: :asc) }

  belongs_to :team

  validates :name, uniqueness: { scope: :team_id }
  validates :virtual_score, numericality: true
  validates :physical_score, numericality: true, allow_nil: true
  validates_presence_of :name, :virtual_score, :team_id
  validate :unique_file_upload

  def unique_file_upload
    if file_already_uploaded?
      errors.add(:model, 'with this checksum has been seen before; please upload a new model')
    end
  end

  def file_already_uploaded?
    ActiveStorage::Blob.where(checksum: package.attachment.blob.checksum)
      .where.not(id: package.attachment.blob.id).exists?
  end

  def update_team_top_model
    sorted = team.models.sort_by do |m|
      [m.physical_score.present? ? m.physical_score : Float::INFINITY, m.virtual_score]
    end

    top = sorted.first

    if (!(top.id == team.top_model_id)) || team.top_model_id.nil?
      team.update!(top_model_id: top.id)
    end
  end

  def update_package_name
    package.blob.update(filename: expected_filename) if package.attached?
  end

  def expected_filename
     "#{team.name.underscore}-#{name.underscore}.#{package.filename.extension}"
  end
end
