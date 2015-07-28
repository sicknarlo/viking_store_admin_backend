class Product < ActiveRecord::Base

  validates :name,
            :presence => {:message => "is required"},
            :uniqueness => {:message => "Product already exists"},
            :length => {:in => 4..40,
                        :message => "Product must be within 4 and 40 characters"}

  validates :price,
            :presence => {:message => "is required"},
            :numericality => { less_than_or_equal_to: 10000, :message => "must be less than $10,000" }

  # def check_price
  #    if price > 10000
  #     errors.add(:price, "must be less than $10,000")
  #    end
  # end

  # def format_price(input)
  #   price = input.gsub("$", "").strip.to_d
  # end

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
