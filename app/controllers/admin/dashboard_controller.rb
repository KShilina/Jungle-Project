class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.count
    puts "HERE", Category.inspect
    @category_count = Category.count
    
  end
end
