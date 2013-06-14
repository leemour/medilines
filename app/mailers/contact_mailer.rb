# encoding: UTF-8

class ContactMailer < ActionMailer::Base
  default from: "contact_form@medilines.ru"
  default to:   CONTACT_MAIL_TO

  def contact_message(message)
    mail(from: "#{message.name} <#{message.email}>",
         subject: "Medilines обратная связь",
         encoding: 'UTF-8',
         body: "#{message.name} пишет:\n" + message.content)
  end
end
