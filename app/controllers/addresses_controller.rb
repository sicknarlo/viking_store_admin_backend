class AddressesController < ApplicationController

def new
  @address = Address.new( :user_id => params[:user_id])
  @states = State.all
end

def create
  @address = Address.new(whitelist_params)
  # @user_id = params[:address][:user_id]
  @states = State.all
  if @address.save
    flash[:success] = "New address created"
    redirect_to user_path(@address.user_id)
  else
    flash.now[:error] = "Address failed to save"
    render :new
  end
end

def index
  if User.exists?(params[:user_id])
    @addresses = Address.where( :user_id => params[:user_id])
    @user = User.find(params[:user_id])
  else
    @addresses = Address.all
  end
end

def show
	@address = Address.find(params[:id])
end

def edit
  @address = Address.find(params[:id])
  @states = State.all
end

def update
  @address = Address.find(params[:id])
  @states = State.all
  if @address.update(whitelist_params)
    flash[:success] = "Address updated"
    redirect_to user_path(@address.user_id)
  else
    flash.now[:error] = "Address failed to save"
    render :edit
  end
end

def destroy
  @address = Address.find(params[:id])
  if @address.destroy
    flash[:success] = "Address destroyed"
    redirect_to addresses_path
  else
    flash[:error] = "Address not destroyed"
    render :edit
  end
end

private

def whitelist_params
  params[:address][:city_id] = find_or_create_city
  params.require(:address).permit(:street_address, :secondary_address, :city_id, :state_id, :zip_code, :user_id)
end

def find_or_create_city
  result = City.select(:id).where("name = ?", params[:address][:city])
  if result.first
    result = result.first.id
  else
    c = City.new(name: params[:address][:city])
    c.save
    result = c.id
  end
  result
end


end
