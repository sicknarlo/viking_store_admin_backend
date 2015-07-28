class Category < ActiveRecord::Base

  has_many :products
  has_many :order_contents, through: :products
  has_many :orders, through: :products

  validates :name,
            :presence => {:message => "Name is required"},
            :uniqueness => {:message => "Category already exists"},
            :length => {:in => 4..16,
                        :message => "Name must be within 4 and 16 characters"}

  def products
    Category.find_by_sql("SELECT products.id, products.name FROM categories
                          JOIN products ON categories.id=products.category_id
                          WHERE categories.id=#{id}")
  end

end
