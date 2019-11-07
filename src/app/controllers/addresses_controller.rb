class AddressesController < ApplicationController
  # calls to the private method 'set address' only in the edit, update, and destroy methods.
  # essentially sets the currently logged in user's address as a variable.
  before_action :set_address, only: [:edit, :update, :destroy]
  # calls a method to allow edit, update and destroy to be carried out only if a user owns the address entry.
  before_action :authorise_user, only: [:edit, :update, :destroy]

# initiates a new address entry
  def new
    # if the logged in user doesn't have an address, it will create a new address and set it as a variable.
    # else it will redirect the user to their 'edit profile' page and display a flash notice.
    if current_user.address == nil
    @address = Address.new
    else 
      flash[:notice] = "You already have a postal address."
      redirect_to edit_registration_path(current_user)
    end
  end

# sends the user to the edit address view.
  def edit
  end

# creates the new address for the logged in user as a result of the form on the 'new address' page.
  def create
    # sets the address variable as the new address, accepting the parameters entered in the form on the 'new address' page.
    @address = Address.new(address_params)
    # sets the address.user variable as the currently logged in user.
    @address.user = current_user

    respond_to do |format|
      # if the address saves, it will redirect to the 'edit profile' page and display a success notice.
      if @address.save
        format.html { redirect_to edit_registration_path(current_user), notice: 'Address was successfully created.' }
        format.json { render edit_registration_path, status: :created, location: @address }
      else
      # if the address doesn't save it will redirect back to the 'new address' page and display a failure notice.
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # updates the address entry for the logged in user as a result of the form on the 'edit address' page.
  def update
    respond_to do |format|
      # if the address updates using the parameters entered in the form on the 'edit address' page, redirect to the 'edit profile' page and display a success notice.
      if @address.update(address_params)
        format.html { redirect_to edit_registration_path, notice: 'Address was successfully updated.' }
        format.json { render edit_registration_path, status: :ok, location: @address }
      # if the address does not update, redirect to the 'edit address' page and display a failure notice.
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # calls for the address of the currently logged in user's address entry to be destroyed.
  def destroy
    @address.destroy
    # once the address is destroyed, it will redirect the user to the 'edit profile' page and a success notice will be displayed.
    respond_to do |format|
      format.html { redirect_to edit_registration_path, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # these methods do not call to a specific view.
  private
    # sets an address instance variable for the address entry found through accepting the number in the url as an address id.
    def set_address
      @address = Address.find(params[:id])
    end

    # checks if the current user is the owner of the address entry being modified. 
    def authorise_user
      # if the logged in user is not the owner of the address entry being modified, it will reditect the user to the root and display a denied alert.
      if current_user != @address.user
        flash[:alert] = "You are not authorised to carry out this action."
        redirect_to root_path
    end
  end

    # sets the parameters to be accepted by address forms.
    def address_params
      params.require(:address).permit(:houseno, :street, :suburb, :state, :postcode)
    end
end
