class AddressesController < ApplicationController

def new
  @address = Address.new( :user_id => params[:user_id])
  @states = State.all
end

def index
  if User.exists?( params[:user_id])
    @addresses = Address.where( :user_id => params[:user_id])
    @user = User.find(params[:user_id])
  else
    @addresses = Address.all
  end
end

def show
	@address = Address.find(params[:id])
end

end
