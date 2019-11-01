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
    @listing = current_user.order.listings
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

