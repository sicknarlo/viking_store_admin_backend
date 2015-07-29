class Address < ActiveRecord::Base

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :billing_users, class_name: "User", foreign_key: :billing_id
  has_many :shipping_users, class_name: "User", foreign_key: :shipping_id

  validates :street_address, :city, :state, :presence => true
  validates :street_address, :city, :length => {:maximum => 64}
  validates :user_id, :if => :check_valid_user

  def full_address
    "#{self.street_address}, #{self.city.name}, #{self.state.name} #{self.zip_code}"
  end

  def check_valid_user
  	User.find(:user_id)
  end

end
