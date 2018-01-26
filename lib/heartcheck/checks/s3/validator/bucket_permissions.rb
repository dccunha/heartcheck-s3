module Heartcheck
  module Checks
    class S3 < Base
      module Validator
        module BucketPermissions
          ERROR = 'user dont have right permissions'.freeze

          def self.validate!(connector:, service:)
            return if service.fetch(:permissions).to_set == connector.permissions.to_set

            raise ERROR
          end
        end
      end
    end
  end
end
