module Emilito
  module Uploaders
    class AvatarUploader < Shrine
      plugin :determine_mime_type
      plugin :logging, logger: Emilito::Container['logger']
      plugin :pretty_location
      plugin :validation_helpers

      plugin :data_uri, filename: ->(content_type) do
        extension = MIME::Types[content_type].first.preferred_extension
        "avatar_#{Time.current.to_i}.#{extension}"
      end

      Attacher.validate do
        max_size = 1024 * 1024
        msg = I18n.t(:'web.uploaders.max_file_size_mb', max: 1)

        validate_max_size max_size, message: msg
        validate_mime_type_inclusion ['image/gif', 'image/jpeg', 'image/png']
      end
    end
  end
end
