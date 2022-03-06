class TypesController < ApplicationController
  before_action :set_type, only: [:show, :edit, :update, :destroy]

  # GET /types
  def index
    @types = current_user.types.all
  end

  # GET /types/1
  def show
  end

  # GET /types/new
  def new
    @type = current_user.types.new
  end

  # GET /types/1/edit
  def edit
  end

  # POST /types
  def create
    @type = current_user.types.new(type_params)

    if @type.save
      redirect_to types_url, notice: 'Type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /types/1
  def update
    if @type.update(type_params)
      redirect_to types_url, notice: 'Type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /types/1
  def destroy

    if @type[:id] == 1
      message =  "Can't destroy Root Type"
    else
      @type.destroy
      message = "Type Destroyed"
    end

    redirect_to types_url, notice: message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type
      @type = current_user.types.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def type_params
      params.require(:type).permit(:type_name, :colour_code)
    end
end
