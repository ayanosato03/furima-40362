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
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name,:phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end

end
