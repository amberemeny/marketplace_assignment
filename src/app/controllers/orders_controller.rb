require 'stripe'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only, only: [:index]
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def myorder 
    @order = current_user.order
    @listings = current_user.order.listings
    @listingprice = 0
    
    lineitems = []
    current_user.order.listings.each do |line|
      lineitems << {
        name: line.name,
        description: line.info,
        amount: (line.price * 100).to_i,
        currency: 'aud',
        quantity: 1,
      }
    end

    Stripe.api_key = 'sk_test_phmwp2idklIfAPFVwhufh4Zr00wSyqegNR'
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: lineitems,
      success_url: 'http://localhost:3000/',
      cancel_url: 'http://localhost:3000/'
    )
  end

  def addtoorder
    if current_user.order == nil
      current_user.order = Order.create()
    end
    @listing = Listing.find(params[:id])

    if !current_user.order.listings.include?(@listing)
      current_user.order.listings << @listing
    else
      flash[:notice] = "Already added item to cart."
    end
    redirect_to myorder_path
  end

  def removeitem
    item = Listing.find(params[:id])
    if current_user.order.listings.find(item.id)
      current_user.order.listings_orders.where(listing_id: item.id, order_id: current_user.order.id).destroy_all
    else 
      flash[:notice] = "This item is not in your cart."
    end
    redirect_to myorder_path
  end

  # def addtoorder
  #    if current_user.order == nil
  #     current_user.order = Order.create()
  #     current_user.order.listings << @listing
  #    else
  #     redirect_to myorder_path
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :listings_id, :datetime, :completed)
    end

    # def set_listing
    #   @listing = Listing.find(params[:id])
    # end
    def admin_only
      if current_user.has_role? :admin
      else
        flash[:alert] = "You are not authorised to carry out this action."
        redirect_to root_path
      end
    end
  end

