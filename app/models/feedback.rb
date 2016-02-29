class Feedback < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :subject,   :validate => true
  attribute :nickname,  :captcha  => true

    # Declare the e-mail headers. It accepts anything the mail method
    # in ActionMailer accepts.
  def headers
    {
       :subject => "Feedback from our USERS!!",
       :to => "yourresume07@gmail.com",
       :from => %("#{name}" <#{email}>),
     }
   end
end
