# -*- coding: utf-8 -*-
class InvitationMailer < ActionMailer::Base
  default from: "from@example.com"

  def invitation_email(user, invitation)
    @user = user
    @invitation_body = invitation.body
    mail(:to => user.email, :subject => "Pozvánka na aukciu")
  end
end
