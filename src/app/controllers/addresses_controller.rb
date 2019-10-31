class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authorise_user, only: [:edit, :update, :destroy]

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    if current_user.address == nil
    @address = Address.new
    else 
      flash[:notice] = "You already have a postal address."
      redirect_to edit_registration_path(current_user)
    end
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(address_params)
    @address.user = current_user

    respond_to do |format|
      if @address.save
        format.html { redirect_to edit_registration_path(current_user), notice: 'Address was successfully created.' }
        format.json { render edit_registration_path, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to root_path, notice: 'Address was successfully updated.' }
        format.json { render edit_registration_path, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    def authorise_user
      if current_user != @address.user
        flash[:alert] = "You are not authorised to carry out this action."
        redirect_to root_path
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:houseno, :street, :suburb, :state, :postcode)
    end
end
