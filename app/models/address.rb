class Address < ActiveRecord::Base

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :billing_users, class_name: "User", foreign_key: :billing_id
  has_many :shipping_users, class_name: "User", foreign_key: :shipping_id

end
