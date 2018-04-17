class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.where(status: 'PUBLISHED').all    
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

  def show
  end

  def edit
    @categories = Category.all
  end

  def update
    if @post.update(posts_params)
      flash[:notice] = "編輯成功"
      redirect_to root_path
    else
      flash.now[:alert] = "編輯失敗"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
    flash[:alert] = "成功刪除！！"
  end


  #-------------private--------------#

  def posts_params
    params.require(:post).permit(:title, :content, :image,:status, :categories => [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
