class DealerContact < MailForm::Base

  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :address
  attribute :telephone2
  attribute :telephone, :validate => true
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Batukeira Nuevo Distribuidor",
      :to => "grace@batukeira.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
