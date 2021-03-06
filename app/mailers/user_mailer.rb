class UserMailer < ApplicationMailer
  def reminder_email(user, items)
    @items = items
    mail(to: user.email, subject: "You are due to replace items")
  end

  def upcoming_reminder_email(user, items)
    @items = items
    mail(to: user.email, subject: "Tomorrow's Replacements")
  end
end
