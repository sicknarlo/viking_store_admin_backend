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

end
