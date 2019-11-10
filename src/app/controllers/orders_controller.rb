# requires the stripe gem in this controller
require 'stripe'

class OrdersController < ApplicationController
  # calls the set_order method for the show, edit, update and destroy method.
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # a devise method that checks to make sure a user is logged in before continuing.
  before_action :authenticate_user!
  # calls the admin_only method for index.
  before_action :admin_only, only: [:index]
  
  # sets a variable that contains all orders. for admin use only.
  def index
    @orders = Order.all
  end

  # sets a variable for a new order to be created.
  def new
    @order = Order.new
  end

  # creates a new order using the order parameters passed through the addtoorder method.
  def create
    # sets a variable containing the new order created using parameters passed through the addtoorder method.
    @order = Order.new(order_params)

    respond_to do |format|
      # if the order saves, redirect the user to the show order view and display a success message.
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :myorder, status: :created, location: @order }
        # if the order doesn't save, redirect to the listings path and display a failure message.
      else
        format.html { render listings_path }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # custom order - creates variables and initialises process for checkout payment.
  def myorder 
    # creates a variable that contains the currently logged in user's order.
    @order = current_user.order
    # creates a variable that contains the listings inside the currently logged in users order.
    
    if @current_user.order != nil
      @listings = current_user.order.listings
        if @listings != []
    # creates a variable containing an empty array.
          lineitems = []
        # for each listing in the currently logged in user's order, create a hash using the listings details.
        current_user.order.listings.each do |line|
          lineitems << {
            name: line.name,
            description: line.info,
            amount: (line.price * 100).to_i,
            currency: 'aud',
            quantity: 1,
          }
        
          # stripe testing details
          Stripe.api_key = 'sk_test_phmwp2idklIfAPFVwhufh4Zr00wSyqegNR'
          # creates a variable for the checkout session created through stripe.
          @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            line_items: lineitems,
            # url directed to upon success.
            success_url: 'http://localhost:3000/',
            # url directed to upon failure.
            cancel_url: 'http://localhost:3000/'
          )
      end
    end
  end

    
  end

  # custom order - uses logic to create a new order and add listings to an order.
  def addtoorder
    # if the current user doesn't have a user, create one.
    if current_user.order == nil
      current_user.order = Order.create()
    end
    @listing = Listing.find(params[:id])

    # if the user's order doesn't already contain the listing they're attempting to add, add it to the order.
    if !current_user.order.listings.include?(@listing)
      current_user.order.listings << @listing
      # if the cart already contains the listing, display a notice.
    else
      flash[:notice] = "Already added item to cart."
    end
    # on completion of the above, redirect to the user's order.
    redirect_to myorder_path
  end

  # custom method - contains logic to remove a listing from the cart.
  def removeitem
    # sets a variable containing the listing with the id passed through the url.
    item = Listing.find(params[:id])
    # if the currently logged in user's order contains the item's id, destroy the entry only in the join table for listings_orders.
    # doing this will delete the relation, removing the item from the order, without destroying the listing itself.
    if current_user.order.listings.find(item.id)
      current_user.order.listings_orders.where(listing_id: item.id, order_id: current_user.order.id).destroy_all
    else 
      # if no such listing is found in the order, display a notice message.
      flash[:notice] = "This item is not in your cart."
    end
    # on completion of the above, redirect to the user's order.
    redirect_to myorder_path
  end

  # private methods do not send the user to a view.
  private
    # sets a variable containing the order with the id passed through the url.
    def set_order
      @order = Order.find(params[:id])
    end

    # only allows the following parameters to be passed into the order model.
    def order_params
      params.require(:order).permit(:user_id, :listings_id, :datetime, :completed)
    end

    # custom method - contains logic to see if the user is an admin or not.
    def admin_only
      # if the currently logged user has an admin role, let them continue.
      if current_user.has_role? :admin
        # if the user is not an admin, redirect them to the root path and display a denied alert.
      else
        flash[:alert] = "You are not authorised to carry out this action."
        redirect_to root_path
      end
    end
  end

