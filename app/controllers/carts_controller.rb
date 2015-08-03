class CartsController < ApplicationController
  def show
    @cart = session[:cart]
  end

  def add
    if session[:cart]
      session[:cart] << params[:product_id]
    else
      session[:cart] = []
      session[:cart] << params[:product_id]
    end
    flash[:success] = "#{Product.find(params[:product_id]).name} Added to Cart!"
    redirect_to root_path
  end
end
