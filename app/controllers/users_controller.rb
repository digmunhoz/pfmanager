  class UsersController < ApplicationController
    before_action :authenticate_user!    

    def new
      @user = User.new
    end

    def index
      @users = User.all
    end

    # Habilitar qd funcionar a sessao
    # private
    def user_params
              params.require(:user).permit(:email, :name, :username, :password, :password_confirmation)
    end

    def create
      @user = User.new(user_params)
      if @user.save
          redirect_to users_path
      else 
          render action: :new
      end
    end

    def show
      @user = User.find(params[:id])
    end 

    def edit
        @user = User.find(params[:id]) 
    end
     
    def update
      @user = User.find(params[:id]) 
      if @user.update_attributes(user_params)
        redirect_to users_path
      else
        render action: :edit
      end
    end
     
    def destroy
      @user = User.find(params[:id]) 
      @user.destroy
      # sign_out
      redirect_to users_path
    end        
       
  end