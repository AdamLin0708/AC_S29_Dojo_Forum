class Admin::BaseController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "您沒有管理員權限！"
      redirect_to root_path
    end
  end
end
