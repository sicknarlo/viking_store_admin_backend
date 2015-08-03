class StoreController < ApplicationController

  def index
    @cart = session[:cart]
    if @cart
      @cart_count = "(#{@cart.length})"
    else
      @cart_count = ""
    end

    @categories = Category.all
    @filter = params[:filter]
    if @filter
      @products = Product.where(:category_id => @filter)
    else
      @products = Product.all
    end
  end
end
