class BillMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def bill_mail_to
    @bill = params[:bill]
    mail(to: @bill.user.email, subject: 'Your bill resume')
  end
end
