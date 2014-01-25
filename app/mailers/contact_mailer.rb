class ContactMailer < ActionMailer::Base
  default to:   ENV['CONTACT_MAIL']

  def contact_message(message)
    mail(from:    "#{message.name} <#{message.email}>",
         subject: "Medilines обратная связь",
         encoding: "UTF-8",
         body:     "#{message.name} пишет:\n" + message.content)
  end
end
