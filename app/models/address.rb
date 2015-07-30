class Address < ActiveRecord::Base

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :billing_users, class_name: "User", foreign_key: :billing_id
  has_many :shipping_users, class_name: "User", foreign_key: :shipping_id
  has_many :orders

  validates :street_address, :city, :state, :presence => true
  validates :street_address, :city, :length => {:maximum => 64}
  validates :user, :presence => true

  before_destroy :check_order_affiliation

  def check_order_affiliation
    user.orders.select(:checkout_date).where("checkout_date IS NOT NULL").count == 0 ? true : false
  end

  def full_address
    "#{self.street_address}, #{self.city.name}, #{self.state.name} #{self.zip_code}"
  end


end
