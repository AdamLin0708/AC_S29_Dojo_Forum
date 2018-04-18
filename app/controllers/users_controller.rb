class UsersController < ApplicationController

  before_action :set_user, only: [:profile, :edit, :update]

  def profile
    @posts = Post.where(user_id: current_user.id).all
  end

  def edit    
  end


  def update
    if @user.update(users_params)
      flash[:notice] = "編輯成功"      
    else
      flash.now[:alert] = "編輯失敗"      
    end

    redirect_to profile_user_path(@user.id)
  end

  private

  def users_params
    params.require(:user).permit(:username, :introduction, :avatar )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
