class ReferencesController < ApplicationController
  before_action :set_reference, only: [:show, :edit, :update, :destroy]

  # GET /references
  def index
    @references = current_user.references.all
  end

  # GET /references/1
  def show
  end

  # GET /references/new
  def new
    @reference = current_user.references.new
  end

  # GET /references/1/edit
  def edit
  end

  # POST /references
  def create
    @reference = current_user.references.new(reference_params)

    if @reference.save
      #redirect_to @reference, notice: 'Reference was successfully created.'
      redirect_to references_url, notice: 'Reference was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /references/1
  def update
    if @reference.update(reference_params)
      #redirect_to @reference, notice: 'Reference was successfully updated.'
      redirect_to references_url, notice: 'Reference was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /references/1
  def destroy

    if @reference[:id] == 1
      message =  "Can't destroy the No-Reference"
    else
      @reference.destroy
      message =  "Reference Destroyed"
    end

    redirect_to references_url, notice: message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference
      @reference = current_user.references.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reference_params
      params.require(:reference).permit(:author, :title, :year, :url, :info)
    end
end
