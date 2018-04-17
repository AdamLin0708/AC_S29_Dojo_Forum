class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all    
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(posts_params)
    @post.user_id = current_user.id
    
    if @post.save
      flash[:notice] = "新增成功"
      redirect_to root_path
    else
      flash.now[:alert] = "新增失敗！"
      render :new
    end
  end


  #-------------private--------------#

  def posts_params
    params.require(:post).permit(:title, :content, :image, :categories => [])
  end
end
