class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :new

  def index
    @order_address = OrderAddress.new
    @orders = Order.all
    @item = Item.find(params[:item_id])

  end

  def new
  end

  def create

  end

end
