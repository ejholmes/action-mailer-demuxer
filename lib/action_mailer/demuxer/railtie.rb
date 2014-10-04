module ActionMailer
  module Demuxer
    class Railtie < Rails::Railtie
      initializer 'action_mailer.demuxer.add_delivery_method' do
        ActiveSupport.on_load :action_mailer do
          ActionMailer::Base.add_delivery_method :demuxer, ActionMailer::Demuxer::DeliveryMethod
        end
      end
    end
  end
end
