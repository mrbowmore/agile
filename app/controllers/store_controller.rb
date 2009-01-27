class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
  end

  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      flash[:notice] = "Invalid Product"
      redirect_to :action  => :index
    else
    @cart = find_cart
    product = Product.find(params[:id])
    @cart.add_product(product)
    end
  end

  def empy_cart
    session[:cart] = nil
    flash[:notice] = "your cart is currently robbed"
    redirect_to :action  => :index
  end
  
private
  
  def find_cart
    session[:cart] ||= Cart.new
  end
end