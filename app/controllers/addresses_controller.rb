class AddressesController < ApplicationController

def new
  @addresses = Address.new( :user_id => params[:user_id])
end

def index
  if User.exists?( params[:user_id])
    @addresses = Address.where( :user_id => params[:user_id])
    @user = User.find(params[:user_id])
    # @addresses ||= Address.where("user_id = params[:id]")
  else
    @addresses = Address.all
  end
end


end
