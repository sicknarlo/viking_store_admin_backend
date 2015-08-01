class Admin::CreditCardsController < AdminController

  # def show
  #   @credit_card = CreditCard.find(params[:id])
  # end

  def destroy
    session[:return_to] ||= request.referer
    @credit_card = CreditCard.find(params[:id])
    if @credit_card.destroy
      flash[:succes] = "Credit Card removed!"
      redirect_to [:admin, session.delete(:return_to)]
    else
      flash[:danger] = "Credit Card was not removed from account."
      redirect_to [:admin, session.delete(:return_to)]
    end
  end
end
