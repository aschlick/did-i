class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@did-i.com'
  layout 'mailer'
end
