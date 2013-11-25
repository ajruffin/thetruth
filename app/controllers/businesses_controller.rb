class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]
  before_filter :check_if_admin, only: [:new, :create, :destroy]
  before_filter :check_if_editor, only: [:edit, :update]
  before_filter :check_allowed
  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
  end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render action: 'show', status: :created, location: @business }
      else
        format.html { render action: 'new' }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url }
      format.json { head :no_content }
    end
  end

  protected

  def check_allowed
  if signed_in?
    raise 'Only admins allowed!' unless current_user.admin? or current_user.id == @business.user_id
  else
    # or you can use the authenticate_user! devise provides to only allow signed_in users
    raise 'Please sign in!'
  end
  end
  def check_if_admin
  if signed_in?
    raise 'Only admins allowed!' unless current_user.admin?
  else
    # or you can use the authenticate_user! devise provides to only allow signed_in users
    raise 'Please sign in!'
  end
  end
  
  def check_if_editor
  if signed_in?
    raise 'Only admins allowed!' unless current_user.admin? or current_user.id == @business.user_id
  else
    # or you can use the authenticate_user! devise provides to only allow signed_in users
    raise 'Please sign in!'
  end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:name, :address, :city, :state, :zip, :image, :user_id)
    end
end
