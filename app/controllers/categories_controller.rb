class CategoriesController < ApplicationController
  before_action :require_user, only: [:new]
  
  def new
    @category = Category.new
  end
  
  def create   
    @category = Category.new(category_params)
    
    if @category.save
      flash[:notice] = "Category has been created."
      redirect_to posts_path     
    else
      flash[:error] = "Error."
      render :new
    end
  end
  
  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end 
  
end