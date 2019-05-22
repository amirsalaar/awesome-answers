class UserSerializer < ActiveModel::Serializer
  # URL Helpers (e.g. questions_path, answer_url, etc.) are only
  # available on your Controllers and your Views. To make them available
  # elsewhere, you need include that module that holds those methods
  # by doing the following:
  include Rails.application.routes.url_helpers
  
  attributes(
    :id,
    :first_name,
    :last_name,
    :full_name, # `attributes` will work with custom methods
    :updated_at,
    :created_at,
    :avatars
  )

  def avatars
    # has_many_attached :photos
    # object.photos_attachments
    object.avatars_attachments.includes(:blob).map do |attachment|
      {
        id: attachment.id,
        name: attachment.name,
        content_type: attachment.blob.content_type,
        filename: attachment.blob.filename.to_s,
        url: rails_blob_url(attachment)
      }
    end
  end
end
