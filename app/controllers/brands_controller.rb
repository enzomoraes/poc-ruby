include Pagy::Backend

class BrandsController < ApplicationController
  before_action :set_brand, only: %i[ show update destroy activate deactivate ]
  before_action :validate_active_param, only: %i[ index ]

  after_action { pagy_headers_merge(@pagy) if @pagy }

  # GET /brands
  def index
    @pagy, @brands = pagy(Brand.active(@active_status))

    render json: @brands
  end

  # GET /brands/1
  def show
    if @brand.active
      render json: @brand
    else
      head :not_found
    end
  end
  
  # POST /brands
  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      render json: @brand, status: :created, location: @brand
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /brands/1
  def update
    if @brand.update(brand_params)
      render json: @brand
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  # DELETE /brands/1
  def destroy
    @brand.destroy!
  end

  # PATCH /brands/1/activate
  def activate
    if @brand.update(active: true)
      render json: @brand
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  # PATCH /brands/1/deactivate
  def deactivate
    if @brand.update(active: false)
      render json: @brand
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name, :description)
    end
    
    def validate_active_param
      # Check if 'active' parameter is present and valid
      if params[:active].present? && %w(true false).include?(params[:active])
        @active_status = params[:active] == 'true'
      else
        render json: { error: 'Required parameter `active` is missing or invalid' }, status: :unprocessable_entity
      end
    end
end
