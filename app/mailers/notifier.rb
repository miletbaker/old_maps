class Notifier < ActionMailer::Base
  default :from => "Jon Milet Baker <hello@miletbaker.com>", :charset => "utf-8"
  
  def reset_password(user)
    @user = user
    @link = edit_reset_password_url(user.perishable_token)
    mail(:to => user.email, :subject => "Password Reset")
  end
  
  def map_processed(map)
    @user = User.first
    @map = map
    mail(:to => @user.email, :subject => "Map Processed: #{map.title}")
  end
  
end