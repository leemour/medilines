# encoding: UTF-8
class ContactMailer < ActionMailer::Base
  default to:   ENV['BUNDLE_GEMFILE']

  def contact_message(message)
    mail(from: "#{message.name} <#{message.email}>",
         subject: "Medilines обратная связь",
         encoding: 'UTF-8',
         body: "#{message.name} пишет:\n" + message.content)
  end
end
