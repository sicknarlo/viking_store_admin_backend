class AddressesController < ApplicationController

def new
  @address = Address.new( :user_id => params[:user_id])
  @states = State.all
end

def create
  @address = Address.new(whitelist_params)
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

private

def whitelist_params
  params.permit(:address).permit(:street_address, :secondary_address, "city", :state_id, :zip_code, :user_id)
  # params[:city_id] = find_city
end

def find_city
  result = City.select(:id).where("name = ?", params["city"])
  if result.first
    result= result.first.id
  else
    c = City.new(name: params["city"])
    c.save
    c.id
  end
end


end
