module Heartcheck
  module Checks
    class S3 < Base
      module Validator
        module BucketCors
          ERROR = 'bucket dont have right cors rules'.freeze

          def self.validate!(connector:, service:)
            cors = connector.cors
            result = %i(allowed_headers allowed_methods allowed_origins).map do |rule|
              cors.send(rule).to_set == service.fetch(rule).to_set
            end
            return unless result.include?(false)

            raise ERROR
          end
        end
      end
    end
  end
end
