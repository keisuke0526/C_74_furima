class CategoriesController < ApplicationController
  before_action :display_categories, only: :show
  
  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    @items = Item.joins(:category).where(categories: {id: params[:id]})
  end

  def display_categories
    @category = Category.find(params[:id])
    @category_display = @category.children
  end

end
