class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :new

  def index
    @order_address = OrderAddress.new
    @orders = Order.all
    @item = Item.find(params[:item_id])
    if current_user.id != @item.user_id && @item.order.present?
      redirect_to root_path
    end
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name,:phone_number).merge(item_id: params[:item_id], user_id: current_user.id,token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount:@item.price,
      card: order_params[:token],    
      currency: 'jpy'                 
    )
  end
end


