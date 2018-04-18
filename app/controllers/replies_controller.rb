class RepliesController < ApplicationController

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

  private

  def reply_params
    params.require(:reply).permit(:comment, :post_id)
  end

end
