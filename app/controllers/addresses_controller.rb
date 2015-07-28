class AddressesController < ApplicationController

def new

end

def index
  # if User.exists?( params[:user_id])
  	@address = Address.where("user_id = ?", params[:id]) || Address.all
		# @address ||= Address.all
	# 
	# @addresses = User.where( id: params[:user_id] ).first.addresses
end


end
