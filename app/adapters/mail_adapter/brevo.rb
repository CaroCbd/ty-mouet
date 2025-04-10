module MailAdapter
  class Brevo
    def send_now
      api_instance.send_transac_email(email)
    end

    def send_welcome_email_now
      api_instance.send_transac_email(welcome_email)
    end

    def send_new_mouette_email_now
      api_instance.send_transac_email(new_mouette_email)
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

    def welcome_email
      @user = User.last
      ::SibApiV3Sdk::SendSmtpEmail.new(
        {
          to: [{ email: @user.email, name: "test user" }],
          templateId: 3
        }
      )
    end

    def new_mouette_email
      @mouette = Mouette.last
      @user = @mouette.owner
      ::SibApiV3Sdk::SendSmtpEmail.new(
        {
          to: [{email: @user.email, name: "test user"}],
          templateId: 4
        }
      )

    end

    def api_instance
      ::SibApiV3Sdk::TransactionalEmailsApi.new
    end

  end
end
