class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]

  def index
    @new_items = Item.includes(:item_imgs).order('created_at DESC').limit(4)
    @rnd_items = Item.includes(:item_imgs).order('RAND()').limit(4)
  end

  def new
    @item = Item.new
    @item.item_imgs.new
    @category_parent_array = Category.where(ancestry: nil)
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: 'Event was successfully created.'
    else
      @item.item_imgs.new if @item.item_imgs.length == 0
      @category_parent_array = Category.where(ancestry: nil)
      render :new
    end
  end

  def edit
  end

  def show
    @items = Item.includes(:item_imgs).where(category_id: @item.category_id).where.not(id: @item.id).order('RAND()').limit(4)
  end

  def update
    if @item.seller_id == current_user.id && @item.update(item_params)
      redirect_to root_path, notice:'更新しました'
    else
      redirect_to edit_item_path(@item.id), notice: '更新できませんでした' 
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: "商品を削除しました。"
    else
      redirect_to item_path(@item.id), notice: "商品を削除できませんでした。"
    end
  end

end

private

def item_params
  params.require(:item).permit(
    :name, 
    :item_explanation,
    :price, 
    :dealing,
    :shippingarea_id,
    :brand,
    :category_id,
    :itemcondition_id,
    :shippingmethod_id,
    :shippingcost_id,
    :shippingday_id,
    item_imgs_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
end

def set_item
  @item = Item.find(params[:id])
end