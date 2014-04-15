class SessionsController < ApplicationController
  def create

    end
  end

  def destroy
    redirect_to root_url, :notice => 'Logged out!'
  end
end