module Heartcheck
  module Checks
    class S3 < Base
      module Validator
        module BucketAccess
          ERROR = 'bucket not exists'.freeze

          def self.validate!(connector:, service:)
            return if connector.can_access_bucket?

            raise ERROR
          end
        end
      end
    end
  end
end
