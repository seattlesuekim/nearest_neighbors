class UsersController < ApplicationController
  require 'pony'
  def new
    @user = User.new
  end

  def create
    @user = User.create(:email => params[:email])
    if @user.save
      Pony.mail(:to   => params[:email],
                :from => 'noreply@mailworks.org',
                :subject => 'Email Updates',
                :body => "Thank you for signing up for updates. I'll only email you again if it's important!",
                :via  => :sendmail)
      flash[:notice] = 'Signed up!'
    end
    redirect_to root_url
  end

end
