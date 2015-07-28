class Product < ActiveRecord::Base

  validates :name,
            :presence => {:message => "Name is required"},
            :uniqueness => {:message => "Product already exists"},
            :length => {:in => 4..40,
                        :message => "Product must be within 4 and 40 characters"}

  validates :price,
            :presence => {:message => "Price is required"}

  def self.in_last(days=nil)
    if days.nil?
      self.count
    else
      self.where('created_at > ?', DateTime.now - days).count
    end
  end

  def order_count

  end

  def cart_count
    Product.select("COUNT(quantity) AS q_count")
            .joins("JOIN order_contents ON products.id=order_contents.product_id")
            .group("products.id")
            .having("products.id = ?", id)
            .first[:q_count]
  end

  def order_count
    Product.select("COUNT(quantity) AS q_count")
            .joins("JOIN order_contents ON products.id=order_contents.product_id")
            .group("products.id")
            .having("checkout_date IS NOT NULL AND products.id = ?", id)
            .first[:q_count]
  end

  def category
    Product.select("categories.name")
            .joins("JOIN categories ON products.category_id=categories.id")
            .where("products.id = ?", id)
            .first[:name]
  end


end
