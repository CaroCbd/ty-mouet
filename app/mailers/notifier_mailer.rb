class NotifierMailer < ApplicationMailer
  def simple_message(recipient)
    mail(
      to: recipient,
      subject: "Bienvenue chez Ty-Mouet !"
    )

  end
end
