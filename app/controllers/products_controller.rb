class ProductsController < ApplicationController

  def index
    @products = Product.order(:id => :asc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(whitelisted_params)
    if @product.save
      flash[:success] = "New Product Created"
      redirect_to @product
    else
      flash[:error] = "Failed to Create New Product"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update
      flash[:success] = "Product Updated"
      redirect_to @product
    else
      flash[:error] = "Failed to Update Product"
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:success] = "Product Deleted"
      redirect_to index
    else
      flash[:error] = "Failed to Delete Product"
      render :edit
    end
  end

  private

  def whitelisted_params
    params.require(:product).permit(:name, :description, :sku, :price, :category_id)
  end

end
