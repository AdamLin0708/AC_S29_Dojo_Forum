class RepliesController < ApplicationController

  before_action :set_reply, only: [:edit, :update, :destroy]

  def create
    @reply = Reply.new(reply_params)
    @reply.user_id = current_user.id
      
    if @reply.save      
      flash[:notice] = "reply was successfully created"
      redirect_back(fallback_location: root_path)    
    else
      flash.now[:alert] = "reply was failed to create"
      render :index
    end
  end

  def edit
  end

  def update
    @reply.update(params.require(:reply).permit(:comment))
    flash[:notice] = "成功更新您的回覆！"
    redirect_to post_path(@reply.post_id)
  end

  def destroy
    @reply.destroy
    flash[:notice] = "成功刪除您的回覆！"
    redirect_back(fallback_location: root_path)    
  end

  private

  def reply_params
    params.require(:reply).permit(:comment, :post_id)
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end

end
