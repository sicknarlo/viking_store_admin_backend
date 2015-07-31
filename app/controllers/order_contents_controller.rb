class OrderContentsController < ApplicationController

  def edit
    # @order_contents = OrderContent.where(:order_id => @order.id)

  end

  def update 
    @order_contents = OrderContent.where(:order_id => @order.id)
    a = params[order][order_contents_attributes]
    @order_contents.update(a)
    fail
  end

  def destroy
  end
end
