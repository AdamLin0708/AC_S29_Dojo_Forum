class CategoriesController < ApplicationController

  skip_before_action :authenticate_user!

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @posts = @category.setted_posts.where(status: 'PUBLISHED').order(created_at: :desc).page(params[:page]).per(10)
  end

end
