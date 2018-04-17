class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def update

    @user = User.find(params[:id])
    @user.role = params[:role]
    @user.save!

    flash[:notice] = "編輯成功"    
    redirect_back(fallback_location: root_path)    
    
  end


end
