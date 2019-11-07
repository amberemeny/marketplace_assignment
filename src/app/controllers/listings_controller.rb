class ListingsController < ApplicationController
  # calls the set_listing method that essentially sets a listing entry as a variable for the show, edit, update and destroy methods.
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # calls the authorise_user method for the edit, update and destroy methods.
  before_action :authorise_user, only: [:edit, :update, :destroy]
 
  # sets a variable containing all listing entries so they can be displayed on one page.
  def index
    @listings = Listing.all
  end

  # sends the user to the show listing view.
  def show
  end

  def new
    # if the user is signed in, a new listing will be set as a variable.
    if user_signed_in?
      @listing = Listing.new
      # if the user is not signed in, they will be sent to the sign in page and a notice will be displayed.
    else 
      flash[:notice] = "You are not signed in."
      redirect_to user_session_path
    end
  end

  # sends the user to the edit listing view.
  def edit
  end

  # creates a new listing using the parameters entered in the new listing page form.
  def create
    # sets a variable as a new listing using the new listing form parameters.
    @listing = Listing.new(listing_params)
    # sets a variable for the currently logged in user.
    @listing.user = current_user
    # a cloudinary helper variable to accept the image parameters from the image uploader.
    @listing.image.attach(listing_params[:image])
    respond_to do |format|
      # if the listing saves, redirect to the show page for the created listing and display a success notice.
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
        # if the listing doesn't save, redirect to the new listing form and display a failure notice.
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # updates the listing using the parameters entered from the edit listing form.
  def update
    # a cloudinary helper variable to accept the image parameters from the image uploader.
    @listing.image.attach(listing_params[:image])
    respond_to do |format|
      # if the listing updates using the parameters entered from the edit listing form, redirect to the listing and display a success notice.
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
        # if the listing doesn't update, reditect to the edit listing form and display a failure notice.
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # destroys the listing entry associated with the id revieved from the url.
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # custom method - sets the listing variable to contain all the listings associated with the currently logged in user.
  def mylistings
    @listings = current_user.listings.all
  end

  # private methods do not send the user to a view.
  private
    # sets a variable for the listing entry with the id passed into the url path.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # sets the parameters to be accepted from the listing forms.
    def listing_params
      params.require(:listing).permit(:name, :user_id, :species, :info, :price, :image)
    end

    # allows methods to be carried out only if the current user owns the listing being modified.
    def authorise_user
      # if the current user doesn't own the listing being modified, redirect to the listings index path and display a denied alert.
      if current_user != @listing.user
        flash[:alert] = "You are not authorised to carry out this action."
        redirect_to listings_path
    end
  end
end
