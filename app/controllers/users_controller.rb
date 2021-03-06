class UsersController < ApplicationController
  def new
      @user = User.new
  end
    
  def create
    @user = User.new(params[:user])
    if @user.save
        sign_in @user
        flash[:success] = "Welcome to Account Hero!"
        redirect_to root_path
    else
        render 'new'
    end
  end
    
    def update
        if @user.update_attributes(params[:user])
            flash[:success] = "Profile updated"
            sign_in @user
            redirect_to @user
            else
            render 'edit'
        end
    end
    
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed."
        redirect_to users_url
    end
end

private

def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
end

def admin_user
    redirect_to(root_path) unless current_user.admin?
end
end
