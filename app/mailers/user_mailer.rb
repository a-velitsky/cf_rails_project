class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def contact_form(email, name, message)
  @message = message
    mail(:from => email,
        :to => 'a.velitsky@gmail.com',
        :subject => "A new contact form message from #{name}")
  end

  def paid_success(user, product)
    @user = user
    @product = product
    mail( :from => 'aron.eidelman@gmail.com',
          :to => user.email,
          :subject => "Confirmation of Order and Payment from A 2 Accessories")
  end
end