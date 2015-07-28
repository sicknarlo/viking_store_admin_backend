class Address < ActiveRecord::Base

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :billing_users, class_name: "User", foreign_key: :billing_id
  has_many :shipping_users, class_name: "User", foreign_key: :shipping_id

  def full_address
    "#{self.street_address}, #{self.city.name}, #{self.state.name} #{self.zip_code.to_s}"
  end

end
