require 'spec_helper'
require 'action_mailer'
require 'action-mailer-demuxer'

class SmsDeliveryMethod
  attr_accessor :settings

  class << self
    attr_accessor :deliveries
  end

  def initialize(values)
    self.settings = values
  end

  def deliver!(mail)
    self.class.deliveries << []
  end
end

ActionMailer::Base.add_delivery_method :demuxer, ActionMailer::Demuxer::DeliveryMethod
ActionMailer::Base.delivery_method = :demuxer
ActionMailer::Base.demuxer_settings = { email: :test, sms: SmsDeliveryMethod }

class NoType < ActionMailer::Base
  def welcome
    mail to: 'foo@example.com', body: 'text'
  end
end

class Emailer < ActionMailer::Base
  default type: :email, from: 'from@example.com'

  def welcome
    mail to: 'to@example.com', body: 'text'
  end
end

class Sms < ActionMailer::Base
  default type: 'sms'

  def welcome
    mail to: '+183112345678', body: 'text'
  end
end

describe ActionMailer::Demuxer do
  before do
    SmsDeliveryMethod.deliveries = []
  end

  it 'raises an exception if the mailer does not define a type' do
    expect {
      NoType.welcome.deliver
    }.to raise_error ActionMailer::Demuxer::DeliveryMethod::MissingType
  end

  it 'demuxes email' do
    expect { Emailer.welcome.deliver }.to change { ActionMailer::Base.deliveries.length }.by(1)
  end

  it 'demuxes sms' do
    expect { Sms.welcome.deliver }.to change { SmsDeliveryMethod.deliveries.length }.by(1)
  end
end
