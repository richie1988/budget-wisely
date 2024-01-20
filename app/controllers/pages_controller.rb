class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:splash]
  def splash
    if user_signed_in?
      redirect_to user_expenses_path(current_user)
    else
      render :splash
    end
  end
end
