class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    before_action :set_user, only: %i[ show edit update destroy ]
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        sign_in(@user)
        redirect_to root_path, notice: 'Successfully signed up.'
      else
        render :new
      end
    end

    def edit
    end
  
    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
  end