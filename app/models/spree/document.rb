class Spree::Document < Spree::Asset
  has_attached_file :attachment

  # rubocop:disable LineLength
  validates_attachment :attachment,
                       presence: true,
                       content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif application/pdf application/msword text/plain) }
end
