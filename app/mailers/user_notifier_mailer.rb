# frozen_string_literal: true

class UserNotifierMailer < ApplicationMailer
  default from: 'dreamsaurav7373@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_import_email(successfull, unsuccessfull)
    @to = 'dhakalnishan983@gmail.com'
    @successfull = successfull,
                   @unsuccessfull = unsuccessfull
    # #   @count = count,
    #   @errors = errors
    # @user = user
    mail(to: @to,
         # :subject => 'Thanks for signing up for our amazing app' )
         successfull: @successfull,
         unsuccessfull: @unsuccessfull)
    #  count: @count,
    #  errors: @errors
  end
end
