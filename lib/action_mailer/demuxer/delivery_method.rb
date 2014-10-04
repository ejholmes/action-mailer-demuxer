module ActionMailer
  module Demuxer
    class DeliveryMethod
      MissingType = Class.new(StandardError)

      attr_accessor :settings

      def initialize(values)
        self.settings = values.symbolize_keys
      end

      def deliver!(mail)
        type   = mail.default :type
        raise MissingType unless type

        method = settings[type.to_sym]
        ActionMailer::Base.wrap_delivery_behavior(mail, method)
        mail.deliver!
      end
    end
  end
end
