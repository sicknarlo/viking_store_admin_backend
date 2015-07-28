module UsersHelper

  def display_address(type, user)
    if user.default_billing_address && type == "billing"
      user.default_billing_address.full_address
    elsif user.default_shipping_address && type == "shipping"
      user.default_shipping_address.full_address
    else
      "No default #{type} address on file."
    end
  end
end
