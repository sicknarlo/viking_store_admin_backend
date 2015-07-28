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
    @product.price = params[:product][:price].gsub("$","").strip.to_f
    @product.sku = (Faker::Code.ean).to_i
    if @product.save
      flash[:success] = "New Product Created"
      redirect_to products_path
    else
      flash[:error] = @product.errors.full_messages.first
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(whitelisted_params)
      flash[:success] = "Product Updated"
      redirect_to products_path
    else
      flash[:error] = @product.errors.full_messages.first
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:success] = "Product Deleted"
      redirect_to index
    else
      flash[:error] = @product.errors.full_messages.first
      render :edit
    end
  end

  private

  def whitelisted_params
    params.require(:product).permit(:name, :description, :sku, :price, :category_id)
  end

end
