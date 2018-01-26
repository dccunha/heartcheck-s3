require 'heartcheck/checks/s3/connector'
require 'heartcheck/checks/s3/validator'

module Heartcheck
  module Checks
    # Check for a redis service
    # Base is set in heartcheck gem
    class S3 < Base
      # validate service connection
      #
      # @retun [void]
      def validate
        services.each do |service|
          begin
            connector = Connector.new(
              conn: service.fetch(:connection),
              bucket: service.fetch(:bucket)
            )

            Validator.run(connector: connector, service: service)
          rescue StandardError => e
            append_error("#{e.class.name} - #{e.message}")
          end
        end
      end

      private

      # customize the error message
      # It's called in Heartcheck::Checks::Base#append_error
      #
      # @param name [String] An identifier of service
      # @param key_error [Symbol] name of action
      #
      # @return [void]
      def custom_error(message)
        @errors << message
      end
    end
  end
end
