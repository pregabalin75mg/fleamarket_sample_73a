class ProductsController < ApplicationController
  # before_action :move_to_login, only: [:new]

  # before_action :set_product, except: [:index, :new, :create]
  
  def index
    @products = Product.where(status: 0)
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @images = Image.where(product_id: @product[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    product = Product.find(params[:id])
      if product.user_id == current_user.id
        product.destroy
        redirect_to "/products", method: :get,  notice: '商品を削除しました'
      end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :brand, :condition_id, :delivery_cost_id, :region_id, :preparation_day_id, :price, images_attributes: [:src], categories_attributes: [:category_name]).merge(user_id: current_user.id)  
  end

  # def set_product
  #   @product = Product.find(params[:id])
  # end
end
