class Product < ActiveRecord::Base

  validates :name,
            :presence => {:message => "Name is required"},
            :uniqueness => {:message => "Product already exists"},
            :length => {:in => 4..40,
                        :message => "Product must be within 4 and 40 characters"}

  validates :price,
            :presence => {:message => "Price is required"},
            # :check_price? => {:message => "Price must be less than $10,000"}
            :numericality => { greater_than: 10000 }



  def check_price?
    format_price(input_price) < 10000
  end

  def format_price(input)
    price = input.gsub("$", "").strip.to_d
  end

  def self.in_last(days=nil)
    if days.nil?
      self.count
    else
      self.where('created_at > ?', DateTime.now - days).count
    end
  end

  def cart_count
    Product.select("COUNT(quantity) AS q_count")
            .joins("JOIN order_contents ON products.id=order_contents.product_id")
            .group("products.id")
            .having("products.id = ?", id)
            .first[:q_count]
  end

  def order_count
    p = Product.select("COUNT(quantity)").joins("JOIN order_contents ON products.id=order_contents.product_id").joins("JOIN orders ON order_contents.order_id = orders.id").where("orders.checkout_date IS NOT NULL AND products.id = ?", id).group("products.id")
    return p.first.count
  end

  def category
    Product.select("categories.name")
            .joins("JOIN categories ON products.category_id=categories.id")
            .where("products.id = ?", id)
            .first[:name]
  end


end
