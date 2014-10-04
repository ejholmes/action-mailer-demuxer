module ActionMailer
  module Demuxer
    class Railtie < Rails::Railtie
      configure do
        ActionMailer::Base.add_delivery_method :demuxer, ActionMailer::Demuxer::DeliveryMethod
      end
    end
  end
end
