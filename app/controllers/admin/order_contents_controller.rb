class Admin::OrderContentsController < AdminController

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
    @order_content = OrderContent.find(params[:id])
    if @order_content.destroy
      flash[:success] = "Item Removed from Cart"
      redirect_to [:admin, order_path(params[:order_id])]
    else
      flash[:error] = "Item Not in Cart"
      redirect_to [:admin, order_edit_path(params[:order_id])]
    end
  end
end
