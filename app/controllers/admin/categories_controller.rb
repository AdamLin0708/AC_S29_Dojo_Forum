class Admin::CategoriesController < Admin::BaseController

  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def create

    @category = Category.new
    @category.name = params[:name]
    if @category.save
        flash[:notice] = "新增成功"         
    else
        flash[:alert] = "新增失敗" 
    end

    redirect_back(fallback_location: root_path)

  end

  def edit    
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "編輯成功"      
    else
      flash.now[:alert] = "編輯失敗"      
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @category.destroy
    flash[:alert] = "成功刪除！！"
    redirect_back(fallback_location: root_path)    
  end


  private 

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
