require 'heartcheck/checks/s3/validator/bucket_access'
require 'heartcheck/checks/s3/validator/bucket_permissions'
require 'heartcheck/checks/s3/validator/bucket_cors'

module Heartcheck
  module Checks
    class S3 < Base
      module Validator
        UNKNOWN_CHECK = 'Unknown Check: %s'.freeze

        def self.run(connector:, service:)
          klass = case service.fetch(:check)
                  when :bucket_access
                    BucketAccess
                  when :bucket_permissions
                    BucketPermissions
                  when :bucket_cors
                    BucketCors
                  else
                    raise format(UNKNOWN_CHECK, service.fetch(:check))
                  end

          klass.validate!(connector: connector, service: service)
        end
      end
    end
  end
end
