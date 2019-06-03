class Model < ApplicationRecord
  has_one_attached :package

  default_scope { order(physical_score: :asc, virtual_score: :asc) }

  belongs_to :team

  validates :name, uniqueness: { scope: :team_id }
  validates :virtual_score, :physical_score, numericality: true
  validates_presence_of :name, :virtual_score, :team_id
  validate :unique_file_upload

  def unique_file_upload
    if file_already_uploaded?
      errors.add(:model, 'a file with this checksum has been seen before; please upload a new model')
    end
  end

  def file_already_uploaded?
    ActiveStorage::Blob.where(checksum: package.attachment.blob.checksum)
      .where.not(id: package.attachment.blob.id).exists?
  end
end
