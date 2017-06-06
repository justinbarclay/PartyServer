class UserMailer < ActionMailer::Base
  default from: 'jbarclay@ualberta.ca'

  # Handles emailing of invite token to new users
  def invite_user(user)
    @user = user
    token = SecureRandom.uuid
    @user.invite_token = token
    @url = Rails.application.config.domain.to_s + "/signup/#{token}"
    if @user.save
      mail(to: @user.email, subject: 'Welcome to the Party')
    else
      puts @user.errors.full_messages
    end
  end

  # Handles emailing of reset token to users
  def reset_password_email(user)
    @user = user
    token = SecureRandom.uuid
    @user.reset_token = token
    @url = Rails.application.config.domain.to_s + "/reset-password/#{token}"
    if @user.save
      mail(to: @user.email, subject: 'Party Password Reset')
    else
      puts "Unable to reset password"
    end
  end  
end
