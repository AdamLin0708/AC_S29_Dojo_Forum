class PostsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @posts = Post.where(status: 'PUBLISHED').page(params[:page]).per(10)
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(posts_params)
    @post.user_id = current_user.id
    
    if params[:post]['categories'].nil?
      flash.now[:alert] = "請至少選擇一個分類！" 
      @categories = Category.all
      render :new
    else  
      @post.save!
      params[:post]['categories'].each do |item|
        @post_category = PostCategory.create(
          post_id: @post.id,
          category_id: item
        )
        @post_category.save!
      end 
      if posts_params[:status] == 'DRAFT'
        flash[:notice] = "文章儲存為草稿！"
        redirect_to draft_user_path(@post.user.id)
      else
        flash[:notice] = "文章發佈成功！"  
        redirect_to post_path(@post.id)
      end
    end
    
  end

  def show
    @post.increment    
  end

  def edit
    @previous_url = Rails.application.routes.recognize_path(request.referrer)[:controller]
    @categories = Category.all
  end

  def update

    if params[:post]['categories'].nil?
      flash.now[:alert] = "請至少選擇一個分類！"
      @categories = Category.all
      render :edit 
    else  
      @post.update(posts_params)
      PostCategory.where(post_id: @post.id).destroy_all
      params[:post]['categories'].each do |item|
        @post_category = PostCategory.create(
          post_id: @post.id,
          category_id: item
        )
        @post_category.save!
      end 

      if posts_params[:status] == 'DRAFT'
        flash[:notice] = "文章儲存為草稿！"
        redirect_to draft_user_path(@post.user.id)
      else
        flash[:notice] = "文章發佈成功！"  
        redirect_to post_path(@post.id)
      end
    end              

  end

  def destroy
    @previous_url = Rails.application.routes.recognize_path(request.referrer)[:controller]
    @post.destroy
    flash[:alert] = "成功刪除！！"

    if @previous_url == 'users'
      redirect_to draft_user_path(@post.user.id)
    else
      @categories = Category.all
      @posts = Post.where(status: 'PUBLISHED').page(params[:page]).per(10)
      render :index
    end     
    
  end

  def feeds
    @users = User.all
    @categories = Category.all
    @posts = Post.all
    @replies = Reply.all
    @popular_posts = Post.order(replies_count: :desc).limit(10)
    @popular_users = User.order(replies_count: :desc).limit(10)
  end


  #-------------private--------------#

  private

  def posts_params
    params.require(:post).permit(:title, :content, :image,:status )
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
