module Heartcheck
  module Checks
    class S3 < Base
      class Connector
        def initialize(conn:, bucket:)
          @conn = conn
          @bucket = bucket
        end

        def can_access_bucket?
          @can_access_bucket ||= conn.bucket(bucket).exists?
        end

        def permissions
          @permissions ||= conn.bucket(bucket).acl.grants.map(&:permission)
        end

        def cors
          @cors ||= conn.bucket(bucket).cors.cors_rules.first
        end

        private

        attr_reader :conn, :bucket
      end
    end
  end
end
