module MailAdapter
  class Brevo
    def send_now
      api_instance.send_transac_email(email)
    end

    private
    def email
      ::SibApiV3Sdk::SendSmtpEmail.new(
        {
          to: [{email: "mvives.dev@gmail.com", name: "test user"}],
          templateId: 1
        }
      )
    end
    def api_instance
      ::SibApiV3Sdk::TransactionalEmailApi.new
    end

    end
  end
end
